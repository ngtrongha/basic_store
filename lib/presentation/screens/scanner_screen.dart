import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../l10n/app_localizations.dart';

@RoutePage()
class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen>
    with SingleTickerProviderStateMixin {
  final MobileScannerController _controller = MobileScannerController();
  late AnimationController _animationController;
  late Animation<double> _animation;

  bool _handled = false;
  bool _continuous = false;
  bool _torchOn = false;
  final Set<String> _scanned = {};

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    final scanAreaSize = size.width * 0.7;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Camera view
          MobileScanner(controller: _controller, onDetect: _handleDetect),

          // Overlay with cutout
          _buildScanOverlay(scanAreaSize, colorScheme),

          // Animated scan line
          _buildScanLine(scanAreaSize),

          // Top bar
          _buildTopBar(context, l10n, colorScheme),

          // Bottom controls
          _buildBottomControls(context, l10n, colorScheme),

          // Scanned items panel (continuous mode)
          if (_continuous && _scanned.isNotEmpty)
            _buildScannedPanel(context, l10n, colorScheme),
        ],
      ),
    );
  }

  Widget _buildScanOverlay(double scanAreaSize, ColorScheme colorScheme) {
    return CustomPaint(
      painter: _ScanOverlayPainter(
        scanAreaSize: scanAreaSize,
        borderColor: colorScheme.primary,
        overlayColor: Colors.black.withOpacity(0.6),
      ),
      child: const SizedBox.expand(),
    );
  }

  Widget _buildScanLine(double scanAreaSize) {
    final screenSize = MediaQuery.of(context).size;
    final left = (screenSize.width - scanAreaSize) / 2;
    final top = (screenSize.height - scanAreaSize) / 2;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Positioned(
          left: left + 4,
          top: top + 4 + (_animation.value * (scanAreaSize - 8)),
          child: Container(
            width: scanAreaSize - 8,
            height: 2,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.primary,
                  Colors.transparent,
                ],
                stops: const [0, 0.2, 0.8, 1],
              ),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                  blurRadius: 8,
                  spreadRadius: 2,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTopBar(
    BuildContext context,
    AppLocalizations l10n,
    ColorScheme colorScheme,
  ) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.fromLTRB(
          8,
          MediaQuery.of(context).padding.top + 8,
          8,
          16,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black.withOpacity(0.7), Colors.transparent],
          ),
        ),
        child: Row(
          children: [
            // Back button
            Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            const SizedBox(width: 12),
            // Title
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.scanBarcode,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    _continuous
                        ? 'Chế độ quét liên tục • ${_scanned.length} mã'
                        : 'Đưa mã vạch vào khung hình',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            // Torch button
            Container(
              decoration: BoxDecoration(
                color: _torchOn
                    ? colorScheme.primary
                    : Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                icon: Icon(
                  _torchOn ? Icons.flash_on_rounded : Icons.flash_off_rounded,
                  color: Colors.white,
                ),
                onPressed: _toggleTorch,
                tooltip: 'Đèn flash',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomControls(
    BuildContext context,
    AppLocalizations l10n,
    ColorScheme colorScheme,
  ) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.fromLTRB(
          16,
          24,
          16,
          MediaQuery.of(context).padding.bottom + 16,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [Colors.black.withOpacity(0.8), Colors.transparent],
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Mode toggle
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildModeButton(
                    icon: Icons.qr_code_scanner_rounded,
                    label: 'Quét 1 lần',
                    isSelected: !_continuous,
                    onTap: () => _setMode(false),
                    colorScheme: colorScheme,
                  ),
                  const SizedBox(width: 4),
                  _buildModeButton(
                    icon: Icons.playlist_add_check_rounded,
                    label: 'Quét liên tục',
                    isSelected: _continuous,
                    onTap: () => _setMode(true),
                    colorScheme: colorScheme,
                  ),
                ],
              ),
            ),
            if (_continuous) ...[
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: _scanned.isEmpty ? null : _confirmScanned,
                      icon: const Icon(Icons.check_rounded),
                      label: Text('Xác nhận (${_scanned.length})'),
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: IconButton(
                      onPressed: _clearScanned,
                      icon: const Icon(Icons.delete_sweep_rounded),
                      color: Colors.white,
                      tooltip: 'Xóa tất cả',
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildModeButton({
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
    required ColorScheme colorScheme,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? colorScheme.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 20,
              color: isSelected ? colorScheme.onPrimary : Colors.white70,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? colorScheme.onPrimary : Colors.white70,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScannedPanel(
    BuildContext context,
    AppLocalizations l10n,
    ColorScheme colorScheme,
  ) {
    return Positioned(
      left: 16,
      right: 16,
      bottom: MediaQuery.of(context).padding.bottom + 140,
      child: Container(
        constraints: const BoxConstraints(maxHeight: 150),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.qr_code_2_rounded,
                  color: colorScheme.primary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Đã quét: ${_scanned.length}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Flexible(
              child: SingleChildScrollView(
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _scanned.map((code) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            code,
                            style: TextStyle(
                              fontSize: 12,
                              color: colorScheme.onPrimaryContainer,
                            ),
                          ),
                          const SizedBox(width: 4),
                          GestureDetector(
                            onTap: () => _removeScanned(code),
                            child: Icon(
                              Icons.close_rounded,
                              size: 16,
                              color: colorScheme.onPrimaryContainer,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============ Actions ============

  void _handleDetect(BarcodeCapture capture) async {
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
        setState(() {});
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.check_circle_rounded, color: Colors.white),
                const SizedBox(width: 8),
                Expanded(child: Text('Đã quét: $value')),
              ],
            ),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            duration: const Duration(seconds: 1),
            margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height * 0.3,
              left: 16,
              right: 16,
            ),
          ),
        );
      }
    } else {
      if (_handled) return;
      _handled = true;
      if (!mounted) return;
      Navigator.of(context).pop(value);
    }
  }

  void _toggleTorch() async {
    await _controller.toggleTorch();
    setState(() => _torchOn = !_torchOn);
    HapticFeedback.selectionClick();
  }

  void _setMode(bool continuous) {
    setState(() {
      _continuous = continuous;
      _handled = false;
    });
    HapticFeedback.selectionClick();
  }

  void _confirmScanned() {
    Navigator.of(context).pop(_scanned.toList());
  }

  void _clearScanned() {
    setState(() => _scanned.clear());
    HapticFeedback.selectionClick();
  }

  void _removeScanned(String code) {
    setState(() => _scanned.remove(code));
    HapticFeedback.selectionClick();
  }
}

// ============ Scan Overlay Painter ============

class _ScanOverlayPainter extends CustomPainter {
  final double scanAreaSize;
  final Color borderColor;
  final Color overlayColor;

  _ScanOverlayPainter({
    required this.scanAreaSize,
    required this.borderColor,
    required this.overlayColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final scanRect = Rect.fromCenter(
      center: center,
      width: scanAreaSize,
      height: scanAreaSize,
    );

    // Draw overlay with cutout
    final overlayPath = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..addRRect(RRect.fromRectAndRadius(scanRect, const Radius.circular(20)))
      ..fillType = PathFillType.evenOdd;

    canvas.drawPath(overlayPath, Paint()..color = overlayColor);

    // Draw corner borders
    final borderPaint = Paint()
      ..color = borderColor
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    const cornerLength = 30.0;
    const radius = 20.0;

    // Top-left corner
    canvas.drawPath(
      Path()
        ..moveTo(scanRect.left, scanRect.top + cornerLength)
        ..lineTo(scanRect.left, scanRect.top + radius)
        ..quadraticBezierTo(
          scanRect.left,
          scanRect.top,
          scanRect.left + radius,
          scanRect.top,
        )
        ..lineTo(scanRect.left + cornerLength, scanRect.top),
      borderPaint,
    );

    // Top-right corner
    canvas.drawPath(
      Path()
        ..moveTo(scanRect.right - cornerLength, scanRect.top)
        ..lineTo(scanRect.right - radius, scanRect.top)
        ..quadraticBezierTo(
          scanRect.right,
          scanRect.top,
          scanRect.right,
          scanRect.top + radius,
        )
        ..lineTo(scanRect.right, scanRect.top + cornerLength),
      borderPaint,
    );

    // Bottom-left corner
    canvas.drawPath(
      Path()
        ..moveTo(scanRect.left, scanRect.bottom - cornerLength)
        ..lineTo(scanRect.left, scanRect.bottom - radius)
        ..quadraticBezierTo(
          scanRect.left,
          scanRect.bottom,
          scanRect.left + radius,
          scanRect.bottom,
        )
        ..lineTo(scanRect.left + cornerLength, scanRect.bottom),
      borderPaint,
    );

    // Bottom-right corner
    canvas.drawPath(
      Path()
        ..moveTo(scanRect.right - cornerLength, scanRect.bottom)
        ..lineTo(scanRect.right - radius, scanRect.bottom)
        ..quadraticBezierTo(
          scanRect.right,
          scanRect.bottom,
          scanRect.right,
          scanRect.bottom - radius,
        )
        ..lineTo(scanRect.right, scanRect.bottom - cornerLength),
      borderPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _ScanOverlayPainter oldDelegate) {
    return scanAreaSize != oldDelegate.scanAreaSize ||
        borderColor != oldDelegate.borderColor;
  }
}
