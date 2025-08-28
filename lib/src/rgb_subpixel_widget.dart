import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

/// A widget that applies RGB subpixel effect similar to LCD displays
/// 
/// This widget simulates the RGB subpixel structure of LCD displays
/// where each pixel is divided into red, green, and blue vertical strips.
class RgbSubpixelWidget extends StatelessWidget {
  /// Creates an RgbSubpixelWidget
  /// 
  /// [child] is the widget to apply the effect to
  /// [blockSize] controls the pixel size
  /// [intensity] controls the strength of the RGB separation (0.0 to 2.0)
  /// [showGrid] enables/disables the pixel grid overlay
  /// [gridOpacity] controls the opacity of the grid lines
  const RgbSubpixelWidget({
    super.key,
    required this.child,
    this.blockSize = 6.0,
    this.intensity = 1.0,
    this.showGrid = true,
    this.gridOpacity = 0.05,
  });

  /// The child widget to apply the RGB subpixel effect to
  final Widget child;

  /// The size of each pixel block
  final double blockSize;

  /// The intensity of the RGB subpixel effect (0.0 to 2.0)
  final double intensity;

  /// Whether to show the pixel grid overlay
  final bool showGrid;

  /// The opacity of the grid lines
  final double gridOpacity;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(constraints.maxWidth, constraints.maxHeight);
        
        return RepaintBoundary(
          child: CustomPaint(
            painter: RgbSubpixelPainter(
              blockSize: blockSize,
              intensity: intensity,
              showGrid: showGrid,
              gridOpacity: gridOpacity,
            ),
            child: child,
          ),
        );
      },
    );
  }
}

/// Custom painter that creates the RGB subpixel effect
class RgbSubpixelPainter extends CustomPainter {
  const RgbSubpixelPainter({
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
    if (!showGrid || intensity <= 0) return;

    final cellWidth = blockSize;
    final cellHeight = blockSize;
    final subpixelWidth = cellWidth / 3.0; // Divide into R, G, B

    final gridPaint = Paint()
      ..color = Colors.black.withOpacity(gridOpacity)
      ..strokeWidth = 0.5;

    // Draw main pixel grid
    for (double x = 0; x <= size.width; x += cellWidth) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (double y = 0; y <= size.height; y += cellHeight) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    // Draw RGB subpixel separators with reduced opacity
    final subpixelPaint = Paint()
      ..color = Colors.black.withOpacity(gridOpacity * 0.3)
      ..strokeWidth = 0.3;

    for (double x = 0; x <= size.width; x += cellWidth) {
      // Draw R|G separator
      final rgSeparator = x + subpixelWidth;
      if (rgSeparator <= size.width) {
        canvas.drawLine(
          Offset(rgSeparator, 0), 
          Offset(rgSeparator, size.height), 
          subpixelPaint
        );
      }
      
      // Draw G|B separator
      final gbSeparator = x + subpixelWidth * 2;
      if (gbSeparator <= size.width) {
        canvas.drawLine(
          Offset(gbSeparator, 0), 
          Offset(gbSeparator, size.height), 
          subpixelPaint
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant RgbSubpixelPainter oldDelegate) {
    return oldDelegate.blockSize != blockSize ||
           oldDelegate.intensity != intensity ||
           oldDelegate.showGrid != showGrid ||
           oldDelegate.gridOpacity != gridOpacity;
  }
}

/// A widget that combines pixelation with RGB subpixel effect
class PixelatedRgbWidget extends StatelessWidget {
  /// Creates a PixelatedRgbWidget that applies both pixelation and RGB subpixel effects
  const PixelatedRgbWidget({
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
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(constraints.maxWidth, constraints.maxHeight);
        
        return RepaintBoundary(
          child: CustomPaint(
            painter: PixelatedRgbPainter(
              size: size,
              blockSize: blockSize,
              intensity: intensity,
              showGrid: showGrid,
              gridOpacity: gridOpacity,
            ),
            child: child,
          ),
        );
      },
    );
  }
}

/// Custom painter that creates the RGB subpixel effect
class PixelatedRgbPainter extends CustomPainter {
  const PixelatedRgbPainter({
    required this.size,
    required this.blockSize,
    required this.intensity,
    required this.showGrid,
    required this.gridOpacity,
  });

  final Size size;
  final double blockSize;
  final double intensity;
  final bool showGrid;
  final double gridOpacity;

  @override
  void paint(Canvas canvas, Size size) {
    if (intensity <= 0) return;

    final cellWidth = blockSize;
    final cellHeight = blockSize;
    final subpixelWidth = cellWidth / 3.0;

    // Apply RGB subpixel tint overlay (very subtle effect)
    final effectOpacity = (intensity * 0.08).clamp(0.0, 0.3);
    
    for (double y = 0; y < size.height; y += cellHeight) {
      for (double x = 0; x < size.width; x += cellWidth) {
        // Red subpixel area - very subtle red tint
        final redRect = Rect.fromLTWH(x, y, subpixelWidth, cellHeight);
        final redPaint = Paint()
          ..color = Colors.red.withOpacity(effectOpacity)
          ..blendMode = BlendMode.overlay;
        canvas.drawRect(redRect, redPaint);

        // Green subpixel area - very subtle green tint
        final greenRect = Rect.fromLTWH(x + subpixelWidth, y, subpixelWidth, cellHeight);
        final greenPaint = Paint()
          ..color = Colors.green.withOpacity(effectOpacity)
          ..blendMode = BlendMode.overlay;
        canvas.drawRect(greenRect, greenPaint);

        // Blue subpixel area - very subtle blue tint
        final blueRect = Rect.fromLTWH(x + subpixelWidth * 2, y, subpixelWidth, cellHeight);
        final bluePaint = Paint()
          ..color = Colors.blue.withOpacity(effectOpacity)
          ..blendMode = BlendMode.overlay;
        canvas.drawRect(blueRect, bluePaint);
      }
    }

    // Draw grid if enabled
    if (showGrid) {
      final gridPaint = Paint()
        ..color = Colors.black.withOpacity(gridOpacity)
        ..strokeWidth = 0.5;

      // Main pixel grid
      for (double x = 0; x <= size.width; x += cellWidth) {
        canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
      }
      for (double y = 0; y <= size.height; y += cellHeight) {
        canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
      }

      // RGB subpixel separators
      final subpixelPaint = Paint()
        ..color = Colors.black.withOpacity(gridOpacity * 0.4)
        ..strokeWidth = 0.3;

      for (double x = 0; x <= size.width; x += cellWidth) {
        // R|G separator
        final rgSeparator = x + subpixelWidth;
        if (rgSeparator <= size.width) {
          canvas.drawLine(
            Offset(rgSeparator, 0), 
            Offset(rgSeparator, size.height), 
            subpixelPaint
          );
        }
        
        // G|B separator
        final gbSeparator = x + subpixelWidth * 2;
        if (gbSeparator <= size.width) {
          canvas.drawLine(
            Offset(gbSeparator, 0), 
            Offset(gbSeparator, size.height), 
            subpixelPaint
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant PixelatedRgbPainter oldDelegate) {
    return oldDelegate.size != size ||
           oldDelegate.blockSize != blockSize ||
           oldDelegate.intensity != intensity ||
           oldDelegate.showGrid != showGrid ||
           oldDelegate.gridOpacity != gridOpacity;
  }
}
