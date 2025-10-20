import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  final MobileScannerController _controller = MobileScannerController();
  bool _handled = false;
  bool _continuous = false;
  final Set<String> _scanned = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quét mã'),
        actions: [
          IconButton(
            tooltip: 'Bật/Tắt đèn',
            onPressed: () async {
              await _controller.toggleTorch();
              HapticFeedback.selectionClick();
            },
            icon: const Icon(Icons.flash_on),
          ),
          IconButton(
            tooltip: _continuous ? 'Tắt quét liên tục' : 'Bật quét liên tục',
            onPressed: () {
              setState(() {
                _continuous = !_continuous;
                _handled = false;
              });
              HapticFeedback.selectionClick();
            },
            icon: Icon(_continuous ? Icons.pause_circle : Icons.play_circle),
          ),
        ],
      ),
      body: Stack(
        children: [
          MobileScanner(
            controller: _controller,
            onDetect: (capture) async {
              final codes = capture.barcodes;
              if (codes.isEmpty) return;
              final value = codes.first.rawValue;
              if (value == null || value.isEmpty) return;

              // Feedback
              await SystemSound.play(SystemSoundType.click);
              HapticFeedback.mediumImpact();

              if (_continuous) {
                if (_scanned.add(value)) {
                  if (!mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Đã quét: $value (${_scanned.length})'),
                    ),
                  );
                }
              } else {
                if (_handled) return;
                _handled = true;
                if (!mounted) return;
                Navigator.of(context).pop(value);
              }
            },
          ),
          if (_continuous)
            Positioned(
              left: 16,
              right: 16,
              bottom: 24,
              child: Row(
                children: [
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: _scanned.isEmpty
                          ? null
                          : () => Navigator.of(context).pop(_scanned.toList()),
                      icon: const Icon(Icons.check),
                      label: Text('Hoàn tất (${_scanned.length})'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  OutlinedButton.icon(
                    onPressed: () {
                      setState(() => _scanned.clear());
                      HapticFeedback.selectionClick();
                    },
                    icon: const Icon(Icons.restart_alt),
                    label: const Text('Làm mới'),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
