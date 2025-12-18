import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class VoiceInputSheet extends StatefulWidget {
  const VoiceInputSheet({super.key});

  @override
  State<VoiceInputSheet> createState() => _VoiceInputSheetState();
}

class _VoiceInputSheetState extends State<VoiceInputSheet> {
  final stt.SpeechToText _speech = stt.SpeechToText();
  final TextEditingController _textCtrl = TextEditingController();

  bool _initialized = false;
  bool _listening = false;
  bool _userEdited = false;
  String? _error;
  String _status = '';
  String? _localeId;

  @override
  void initState() {
    super.initState();
    _textCtrl.addListener(_onTextChanged);
    _initAndListen();
  }

  @override
  void dispose() {
    _speech.stop();
    _textCtrl.removeListener(_onTextChanged);
    _textCtrl.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    if (!mounted) return;
    setState(() {});
  }

  Future<void> _initAndListen() async {
    final ok = await _speech.initialize(
      onError: (e) {
        if (!mounted) return;
        setState(() => _error = e.errorMsg);
      },
      onStatus: (s) {
        if (!mounted) return;
        setState(() => _status = s);
        if (s == 'done' || s == 'notListening') {
          setState(() => _listening = false);
        }
      },
    );

    if (!mounted) return;
    if (!ok) {
      setState(() {
        _initialized = true;
        _error = 'Không thể khởi tạo nhận dạng giọng nói';
      });
      return;
    }

    try {
      final locales = await _speech.locales();
      final vi = locales
          .where((l) => l.localeId.toLowerCase().startsWith('vi'))
          .toList();
      _localeId = vi.isNotEmpty ? vi.first.localeId : null;
    } catch (_) {
      _localeId = null;
    }

    setState(() => _initialized = true);
    await _startListening();
  }

  Future<void> _startListening() async {
    if (!_speech.isAvailable) return;
    if (_listening) return;

    setState(() {
      _error = null;
      _listening = true;
      _userEdited = false;
    });

    await _speech.listen(
      onResult: (r) {
        if (!mounted) return;
        if (_userEdited) return;
        _textCtrl.text = r.recognizedWords;
        _textCtrl.selection = TextSelection.collapsed(
          offset: _textCtrl.text.length,
        );
      },
      localeId: _localeId,
      listenFor: const Duration(seconds: 30),
      pauseFor: const Duration(seconds: 2),
      listenOptions: stt.SpeechListenOptions(
        partialResults: true,
        cancelOnError: true,
        listenMode: stt.ListenMode.dictation,
      ),
    );
  }

  Future<void> _stopListening() async {
    await _speech.stop();
    if (!mounted) return;
    setState(() => _listening = false);
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + bottomInset),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: colorScheme.outlineVariant,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: _listening
                          ? Colors.red.withOpacity(0.1)
                          : colorScheme.primaryContainer,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      _listening ? Icons.mic : Icons.mic_none,
                      color: _listening ? Colors.red : colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Nhập đơn bằng giọng nói',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        if (_status.isNotEmpty)
                          Text(
                            _listening ? 'Đang nghe...' : _status,
                            style: TextStyle(
                              color: colorScheme.outline,
                              fontSize: 12,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              if (!_initialized)
                const Padding(
                  padding: EdgeInsets.all(24),
                  child: CircularProgressIndicator(),
                )
              else ...[
                if (_error != null) ...[
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.error_outline,
                          color: Colors.red,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            _error!,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
                TextField(
                  controller: _textCtrl,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'Ví dụ: Ông B mua 1 thùng Tiger, 2 lon Pepsi',
                    filled: true,
                    fillColor: colorScheme.surfaceContainerHighest.withOpacity(
                      0.5,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (_) => setState(() => _userEdited = true),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _listening
                            ? _stopListening
                            : _startListening,
                        icon: Icon(
                          _listening ? Icons.stop_rounded : Icons.mic_rounded,
                        ),
                        label: Text(_listening ? 'Dừng' : 'Nghe'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: _textCtrl.text.trim().isEmpty
                            ? null
                            : () =>
                                  Navigator.pop(context, _textCtrl.text.trim()),
                        icon: const Icon(Icons.send_rounded),
                        label: const Text('Tạo đơn'),
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
