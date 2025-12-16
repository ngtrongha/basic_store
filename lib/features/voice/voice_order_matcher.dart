import '../../data/models/customer.dart';
import '../../data/models/product.dart';
import '../../data/repositories/customer_repository.dart';
import '../../data/repositories/product_repository.dart';
import '../../data/services/recent_service.dart';
import 'voice_alias_store.dart';
import 'voice_order_parser.dart';

class VoiceProductCandidate {
  final Product product;
  final double score;

  const VoiceProductCandidate({required this.product, required this.score});
}

class VoiceProductMatchResult {
  final Product? product;
  final double confidence;
  final double margin;
  final List<VoiceProductCandidate> candidates;

  const VoiceProductMatchResult({
    required this.product,
    required this.confidence,
    required this.margin,
    required this.candidates,
  });

  bool get isConfident => product != null;
  bool get needsDisambiguation => product == null && candidates.isNotEmpty;
}

class VoiceOrderMatcher {
  final ProductRepository _productRepo;
  final CustomerRepository _customerRepo;
  final VoiceAliasStore _aliasStore;

  VoiceOrderMatcher({
    ProductRepository? productRepo,
    CustomerRepository? customerRepo,
    VoiceAliasStore? aliasStore,
  }) : _productRepo = productRepo ?? ProductRepository(),
       _customerRepo = customerRepo ?? CustomerRepository(),
       _aliasStore = aliasStore ?? VoiceAliasStore();

  Future<Customer> findOrCreateCustomer(String customerName) async {
    final rawName = customerName.trim();
    final normKey = VoiceOrderParser.normalize(rawName);

    if (normKey.isNotEmpty) {
      final id = await _aliasStore.getCustomerId(normKey);
      if (id != null) {
        final existing = await _customerRepo.getById(id);
        if (existing != null) return existing;
        await _aliasStore.removeCustomerAlias(normKey);
      }
    }

    final hits = await _customerRepo.search(query: rawName, limit: 50);

    Customer? best;
    var bestScore = 0.0;
    var secondScore = 0.0;

    for (final c in hits) {
      final score = _similarity(normKey, VoiceOrderParser.normalize(c.name));
      if (score > bestScore) {
        secondScore = bestScore;
        bestScore = score;
        best = c;
      } else if (score > secondScore) {
        secondScore = score;
      }
    }

    if (best != null && _shouldAutoPickCustomer(bestScore, secondScore)) {
      if (normKey.isNotEmpty) {
        await _aliasStore.saveCustomerAlias(normKey, best.id);
      }
      return best;
    }

    final created = Customer()
      ..name = rawName
      ..phone = null
      ..email = null
      ..tier = 'Bronze'
      ..points = 0;

    await _customerRepo.create(created);

    if (normKey.isNotEmpty) {
      await _aliasStore.saveCustomerAlias(normKey, created.id);
    }

    return created;
  }

  Future<void> rememberCustomerAlias({
    required String phrase,
    required Customer customer,
  }) async {
    final key = VoiceOrderParser.normalize(phrase);
    if (key.isEmpty) return;
    await _aliasStore.saveCustomerAlias(key, customer.id);
  }

  Future<VoiceProductMatchResult> matchProduct({
    required String phrase,
    String? unit,
  }) async {
    final rawPhrase = phrase.trim();
    final phraseKey = VoiceOrderParser.normalize(rawPhrase);
    final unitKey = unit == null ? '' : VoiceOrderParser.normalize(unit);

    final fullKey = unitKey.isEmpty
        ? phraseKey
        : VoiceOrderParser.normalize('$rawPhrase $unit');

    // 1) Alias hit: phrase+unit, then phrase.
    final aliasKeys = <String>[
      if (fullKey.isNotEmpty) fullKey,
      if (phraseKey.isNotEmpty) phraseKey,
    ];

    for (final key in aliasKeys) {
      final id = await _aliasStore.getProductId(key);
      if (id == null) continue;

      final product = await _productRepo.getById(id);
      if (product != null) {
        return VoiceProductMatchResult(
          product: product,
          confidence: 1.0,
          margin: 1.0,
          candidates: [VoiceProductCandidate(product: product, score: 1.0)],
        );
      }

      await _aliasStore.removeProductAlias(key);
    }

    // 2) Candidate retrieval.
    final queryTokens = _pickQueryTokens(rawPhrase);

    var candidates = await _productRepo.searchByTokens(queryTokens, limit: 200);
    if (candidates.isEmpty && queryTokens.length > 1) {
      candidates = await _productRepo.searchByTokens([
        queryTokens.first,
      ], limit: 200);
    }
    if (candidates.isEmpty) {
      candidates = await _productRepo.getAll(limit: 200);
    }

    final recents = (await RecentService.getRecentSkus()).toSet();

    final scored = <VoiceProductCandidate>[];
    for (final p in candidates) {
      final score = _scoreProduct(
        product: p,
        phraseKey: phraseKey,
        unitKey: unitKey,
        recentSkus: recents,
      );
      if (score <= 0) continue;
      scored.add(VoiceProductCandidate(product: p, score: score));
    }

    scored.sort((a, b) => b.score.compareTo(a.score));
    final top = scored.take(10).toList(growable: false);

    if (top.isEmpty) {
      return const VoiceProductMatchResult(
        product: null,
        confidence: 0,
        margin: 0,
        candidates: [],
      );
    }

    final best = top.first;
    final second = top.length > 1 ? top[1].score : 0.0;
    final margin = best.score - second;

    final confident = _shouldAutoPickProduct(best.score, margin);

    return VoiceProductMatchResult(
      product: confident ? best.product : null,
      confidence: best.score,
      margin: margin,
      candidates: top,
    );
  }

  Future<void> rememberProductAlias({
    required String phrase,
    String? unit,
    required Product product,
  }) async {
    final phraseKey = VoiceOrderParser.normalize(phrase);
    if (phraseKey.isNotEmpty) {
      await _aliasStore.saveProductAlias(phraseKey, product.id);
    }

    final unitKey = unit == null ? '' : VoiceOrderParser.normalize(unit);
    if (unitKey.isNotEmpty) {
      final fullKey = VoiceOrderParser.normalize('${phrase.trim()} $unit');
      if (fullKey.isNotEmpty) {
        await _aliasStore.saveProductAlias(fullKey, product.id);
      }
    }
  }

  static List<String> _pickQueryTokens(String phrase) {
    final rawTokens = _splitRawWords(phrase);
    final normTokens = VoiceOrderParser.tokenize(phrase);

    final all = <String>{...rawTokens, ...normTokens}
        .where((t) => t.trim().isNotEmpty)
        .map((t) => t.trim())
        .toList(growable: false);

    // Prefer a few strongest (longest) tokens to keep SQL LIKE queries useful.
    final sorted = [...all]..sort((a, b) => b.length.compareTo(a.length));

    return sorted.take(4).toList(growable: false);
  }

  static List<String> _splitRawWords(String input) {
    final cleaned = input
        .replaceAll(RegExp(r'[^0-9A-Za-zÀ-ỹĐđ\s]+'), ' ')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();

    if (cleaned.isEmpty) return const <String>[];
    return cleaned.split(' ');
  }

  static double _scoreProduct({
    required Product product,
    required String phraseKey,
    required String unitKey,
    required Set<String> recentSkus,
  }) {
    if (phraseKey.isEmpty) return 0.0;

    final nameKey = VoiceOrderParser.normalize(product.name);
    final skuKey = VoiceOrderParser.normalize(product.sku);

    final qTokens = phraseKey.isEmpty ? const <String>[] : phraseKey.split(' ');
    final nameTokens = nameKey.isEmpty ? const <String>[] : nameKey.split(' ');
    final nameTokenSet = nameTokens.toSet();

    var hit = 0;
    for (final t in qTokens) {
      if (t.isEmpty) continue;
      if (nameTokenSet.contains(t)) hit++;
    }

    final tokenScore = qTokens.isEmpty ? 0.0 : hit / qTokens.length;

    final simName = _similarity(phraseKey, nameKey);
    final simSku = _similarity(phraseKey, skuKey);

    if (simSku >= 0.95) return 1.0;

    var score =
        (0.55 * tokenScore) + (0.45 * (simName > simSku ? simName : simSku));

    if (unitKey.isNotEmpty && nameKey.contains(unitKey)) {
      score += 0.03;
    }

    if (recentSkus.contains(product.sku)) {
      score += 0.03;
    }

    if (product.stock > 0) {
      score += 0.01;
    } else {
      score -= 0.01;
    }

    if (score < 0) return 0;
    if (score > 1) return 1;
    return score;
  }

  static bool _shouldAutoPickCustomer(double best, double second) {
    if (best >= 0.90) return true;
    return best >= 0.82 && (best - second) >= 0.12;
  }

  static bool _shouldAutoPickProduct(double best, double margin) {
    if (best >= 0.90) return true;
    return best >= 0.78 && margin >= 0.08;
  }

  static double _similarity(String a, String b) {
    final x = a.trim();
    final y = b.trim();

    if (x.isEmpty && y.isEmpty) return 1.0;
    if (x.isEmpty || y.isEmpty) return 0.0;

    if (x == y) return 1.0;

    final dist = _levenshtein(x, y);
    final maxLen = x.length > y.length ? x.length : y.length;
    if (maxLen == 0) return 1.0;

    final s = 1.0 - (dist / maxLen);
    if (s < 0) return 0.0;
    if (s > 1) return 1.0;
    return s;
  }

  static int _levenshtein(String s, String t) {
    final n = s.length;
    final m = t.length;

    if (n == 0) return m;
    if (m == 0) return n;

    var prev = List<int>.generate(m + 1, (i) => i);
    var curr = List<int>.filled(m + 1, 0);

    for (var i = 1; i <= n; i++) {
      curr[0] = i;
      final sc = s.codeUnitAt(i - 1);

      for (var j = 1; j <= m; j++) {
        final tc = t.codeUnitAt(j - 1);
        final cost = sc == tc ? 0 : 1;

        final deletion = prev[j] + 1;
        final insertion = curr[j - 1] + 1;
        final substitution = prev[j - 1] + cost;

        var min = deletion;
        if (insertion < min) min = insertion;
        if (substitution < min) min = substitution;

        curr[j] = min;
      }

      final tmp = prev;
      prev = curr;
      curr = tmp;
    }

    return prev[m];
  }
}
