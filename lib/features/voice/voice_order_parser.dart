class VoiceOrderCommand {
  final String rawText;
  final String? customerName;
  final List<VoiceOrderLine> lines;

  const VoiceOrderCommand({
    required this.rawText,
    required this.customerName,
    required this.lines,
  });
}

class VoiceOrderLine {
  final String productPhrase;
  final int quantity;
  final String? unit;

  const VoiceOrderLine({
    required this.productPhrase,
    required this.quantity,
    required this.unit,
  });
}

class VoiceOrderParser {
  static final RegExp _actionRe = RegExp(r'\b(mua|lay|dat|order|them|cho)\b');

  static const Map<String, int> _numberWords = {
    'mot': 1,
    'moi': 1,
    'hai': 2,
    'ba': 3,
    'bon': 4,
    'tu': 4,
    'nam': 5,
    'lam': 5,
    'sau': 6,
    'bay': 7,
    'tam': 8,
    'chin': 9,
    'muoi': 10,
  };

  static const Set<String> _units = {
    'thung',
    'loc',
    'chai',
    'lon',
    'hop',
    'goi',
    'bi',
    'tui',
    'khay',
    'cay',
    'bo',
    'cap',
  };

  /// Normalizes Vietnamese text for matching (lowercase, remove diacritics,
  /// keep only letters/digits/spaces, collapse whitespace).
  static String normalize(String input) {
    final canonical = _canonicalizeKeepLength(input);
    return canonical
        .replaceAll(RegExp(r'[^a-z0-9\s]+'), ' ')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }

  static List<String> tokenize(String input) {
    final n = normalize(input);
    if (n.isEmpty) return const <String>[];
    return n.split(' ');
  }

  /// Parse a Vietnamese voice command like:
  /// "Ông B mua 1 thùng Tiger" or "Ông B mua 1 thùng Tiger và 2 lốc Coca".
  static VoiceOrderCommand parse(String rawText) {
    final raw = rawText.trim();
    if (raw.isEmpty) {
      return const VoiceOrderCommand(
        rawText: '',
        customerName: null,
        lines: [],
      );
    }

    final canonical = _canonicalizeKeepLength(raw);
    final actionMatch = _actionRe.firstMatch(canonical);

    if (actionMatch == null) {
      // Fallback: treat the whole sentence as product phrase.
      return VoiceOrderCommand(
        rawText: rawText,
        customerName: null,
        lines: [VoiceOrderLine(productPhrase: raw, quantity: 1, unit: null)],
      );
    }

    final customerRaw = raw.substring(0, actionMatch.start).trim();

    var itemsStart = actionMatch.end;
    while (itemsStart < raw.length &&
        _isWhitespace(raw.codeUnitAt(itemsStart))) {
      itemsStart++;
    }

    final rawItems = itemsStart < raw.length ? raw.substring(itemsStart) : '';
    final canonicalItems = itemsStart < canonical.length
        ? canonical.substring(itemsStart)
        : '';

    final segments = _splitItemSegments(rawItems, canonicalItems);
    final lines = <VoiceOrderLine>[];

    for (final seg in segments) {
      final line = _parseLine(seg);
      if (line != null) lines.add(line);
    }

    return VoiceOrderCommand(
      rawText: rawText,
      customerName: customerRaw.isEmpty ? null : customerRaw,
      lines: lines,
    );
  }

  static List<String> _splitItemSegments(
    String rawItems,
    String canonicalItems,
  ) {
    // Split by: comma, "và", "với", "cùng" (all canonicalized).
    final splitRe = RegExp(r'(?:,|\s+(?:va|voi|cung)\s+)');

    final segments = <String>[];
    var start = 0;
    for (final m in splitRe.allMatches(canonicalItems)) {
      final seg = rawItems.substring(start, m.start).trim();
      if (seg.isNotEmpty) segments.add(seg);
      start = m.end;
    }

    final tail = rawItems.substring(start).trim();
    if (tail.isNotEmpty) segments.add(tail);

    return segments;
  }

  static VoiceOrderLine? _parseLine(String rawSegment) {
    final canonical = _canonicalizeKeepLength(rawSegment);

    var cursor = 0;
    final first = _nextToken(canonical, cursor);
    if (first == null) return null;

    var quantity = 1;
    String? unit;
    var productStart = 0;

    final q = _parseQuantityToken(first.text);
    if (q != null) {
      quantity = q;
      cursor = first.end;

      final maybeUnit = _nextToken(canonical, cursor);
      if (maybeUnit != null && _units.contains(maybeUnit.text)) {
        unit = rawSegment.substring(maybeUnit.start, maybeUnit.end).trim();
        cursor = maybeUnit.end;
      }

      productStart = cursor;
    } else if (_units.contains(first.text)) {
      unit = rawSegment.substring(first.start, first.end).trim();
      cursor = first.end;
      productStart = cursor;
    } else {
      productStart = 0;
    }

    final productPhrase = rawSegment.substring(productStart).trim();
    if (productPhrase.isEmpty) return null;

    return VoiceOrderLine(
      productPhrase: productPhrase,
      quantity: quantity,
      unit: unit,
    );
  }

  static int? _parseQuantityToken(String token) {
    if (token.isEmpty) return null;
    final digits = int.tryParse(token);
    if (digits != null) return digits;
    return _numberWords[token];
  }

  static _Token? _nextToken(String canonical, int from) {
    var i = from;
    while (i < canonical.length && canonical.codeUnitAt(i) == 32) {
      i++;
    }
    if (i >= canonical.length) return null;

    var j = i;
    while (j < canonical.length && canonical.codeUnitAt(j) != 32) {
      j++;
    }

    return _Token(text: canonical.substring(i, j), start: i, end: j);
  }

  static bool _isWhitespace(int codeUnit) {
    return codeUnit == 32 || codeUnit == 9 || codeUnit == 10 || codeUnit == 13;
  }

  static String _canonicalizeKeepLength(String input) {
    final lower = input.toLowerCase();
    final sb = StringBuffer();

    for (final rune in lower.runes) {
      var ch = String.fromCharCode(rune);
      ch = _stripVietnameseDiacriticsChar(ch);

      // Keep [a-z0-9 ] only; turn others into space to preserve indices.
      final code = ch.codeUnitAt(0);
      final isAZ = code >= 97 && code <= 122;
      final is09 = code >= 48 && code <= 57;

      if (isAZ || is09) {
        sb.write(ch);
      } else if (_isWhitespace(code)) {
        sb.write(' ');
      } else {
        sb.write(' ');
      }
    }

    return sb.toString();
  }

  static String _stripVietnameseDiacriticsChar(String ch) {
    // Assumes `ch` is lowercase and a single UTF-16 code unit.
    switch (ch) {
      case 'à':
      case 'á':
      case 'ạ':
      case 'ả':
      case 'ã':
      case 'â':
      case 'ầ':
      case 'ấ':
      case 'ậ':
      case 'ẩ':
      case 'ẫ':
      case 'ă':
      case 'ằ':
      case 'ắ':
      case 'ặ':
      case 'ẳ':
      case 'ẵ':
        return 'a';

      case 'è':
      case 'é':
      case 'ẹ':
      case 'ẻ':
      case 'ẽ':
      case 'ê':
      case 'ề':
      case 'ế':
      case 'ệ':
      case 'ể':
      case 'ễ':
        return 'e';

      case 'ì':
      case 'í':
      case 'ị':
      case 'ỉ':
      case 'ĩ':
        return 'i';

      case 'ò':
      case 'ó':
      case 'ọ':
      case 'ỏ':
      case 'õ':
      case 'ô':
      case 'ồ':
      case 'ố':
      case 'ộ':
      case 'ổ':
      case 'ỗ':
      case 'ơ':
      case 'ờ':
      case 'ớ':
      case 'ợ':
      case 'ở':
      case 'ỡ':
        return 'o';

      case 'ù':
      case 'ú':
      case 'ụ':
      case 'ủ':
      case 'ũ':
      case 'ư':
      case 'ừ':
      case 'ứ':
      case 'ự':
      case 'ử':
      case 'ữ':
        return 'u';

      case 'ỳ':
      case 'ý':
      case 'ỵ':
      case 'ỷ':
      case 'ỹ':
        return 'y';

      case 'đ':
        return 'd';

      default:
        return ch;
    }
  }
}

class _Token {
  final String text;
  final int start;
  final int end;

  const _Token({required this.text, required this.start, required this.end});
}
