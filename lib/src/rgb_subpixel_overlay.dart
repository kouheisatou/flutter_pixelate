import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

/// A simplified and effective RGB subpixel widget
class RgbSubpixelOverlay extends StatelessWidget {
  const RgbSubpixelOverlay({
    super.key,
    required this.child,
    this.blockSize = 6.0,
    this.intensity = 1.0,
    this.showGrid = true,
    this.gridOpacity = 0.05,
  });

  final Widget child;
  final double blockSize;
  final double intensity;
  final bool showGrid;
  final double gridOpacity;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Original child content
        child,
        
        // RGB subpixel overlay
        if (intensity > 0)
          Positioned.fill(
            child: IgnorePointer(
              child: CustomPaint(
                painter: RgbSubpixelOverlayPainter(
                  blockSize: blockSize,
                  intensity: intensity,
                  showGrid: showGrid,
                  gridOpacity: gridOpacity,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

/// Custom painter that creates RGB subpixel overlay
class RgbSubpixelOverlayPainter extends CustomPainter {
  const RgbSubpixelOverlayPainter({
    required this.blockSize,
    required this.intensity,
    required this.showGrid,
    required this.gridOpacity,
  });

  final double blockSize;
  final double intensity;
  final bool showGrid;
  final double gridOpacity;

  @override
  void paint(Canvas canvas, Size size) {
    final cellWidth = blockSize;
    final cellHeight = blockSize;
    final subpixelWidth = cellWidth / 3.0;

    // Calculate effective opacity for RGB tints
    final rgbOpacity = (intensity * 0.03).clamp(0.0, 0.15);

    // Only draw RGB subpixel effect if intensity is significant
    if (rgbOpacity > 0.001) {
      // Draw subtle RGB tint areas
      for (double y = 0; y < size.height; y += cellHeight) {
        for (double x = 0; x < size.width; x += cellWidth) {
          // Red subpixel (left third)
          canvas.drawRect(
            Rect.fromLTWH(x, y, subpixelWidth, cellHeight),
            Paint()
              ..color = Colors.red.withOpacity(rgbOpacity)
              ..blendMode = BlendMode.screen,
          );

          // Green subpixel (middle third)
          canvas.drawRect(
            Rect.fromLTWH(x + subpixelWidth, y, subpixelWidth, cellHeight),
            Paint()
              ..color = Colors.green.withOpacity(rgbOpacity)
              ..blendMode = BlendMode.screen,
          );

          // Blue subpixel (right third)
          canvas.drawRect(
            Rect.fromLTWH(x + subpixelWidth * 2, y, subpixelWidth, cellHeight),
            Paint()
              ..color = Colors.blue.withOpacity(rgbOpacity)
              ..blendMode = BlendMode.screen,
          );
        }
      }
    }

    // Draw grid lines
    if (showGrid) {
      final gridPaint = Paint()
        ..color = Colors.black.withOpacity(gridOpacity)
        ..strokeWidth = 0.5;

      // Main pixel grid (horizontal and vertical lines)
      for (double x = 0; x <= size.width; x += cellWidth) {
        canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
      }
      for (double y = 0; y <= size.height; y += cellHeight) {
        canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
      }

      // RGB subpixel dividers (vertical lines within each pixel)
      final subpixelPaint = Paint()
        ..color = Colors.black.withOpacity(gridOpacity * 0.3)
        ..strokeWidth = 0.2;

      for (double x = subpixelWidth; x < size.width; x += subpixelWidth) {
        // Only draw if it's not on a main grid line
        if (x % cellWidth != 0) {
          canvas.drawLine(Offset(x, 0), Offset(x, size.height), subpixelPaint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant RgbSubpixelOverlayPainter oldDelegate) {
    return oldDelegate.blockSize != blockSize ||
           oldDelegate.intensity != intensity ||
           oldDelegate.showGrid != showGrid ||
           oldDelegate.gridOpacity != gridOpacity;
  }
}
