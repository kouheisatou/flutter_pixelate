import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_shaders/flutter_shaders.dart';

/// A widget that applies retro LCD pixel effect to its child
/// 
/// This widget wraps any child widget and applies a pixelation effect
/// that simulates old LCD displays with customizable block size and
/// optional grid overlay.
class PixelateWidget extends StatelessWidget {
  /// Creates a PixelateWidget
  /// 
  /// [child] is the widget to apply the effect to
  /// [blockSize] controls the pixel size (larger = more pixelated)
  /// [showGrid] enables/disables the LCD grid overlay
  /// [gridOpacity] controls the opacity of the grid lines (0.0 to 1.0)
  const PixelateWidget({
    super.key,
    required this.child,
    this.blockSize = 6.0,
    this.showGrid = true,
    this.gridOpacity = 0.06,
  });

  /// The child widget to apply the pixel effect to
  final Widget child;

  /// The size of each pixel block (larger = more pixelated)
  /// 
  /// Recommended range: 2.0 to 20.0
  final double blockSize;

  /// Whether to show the LCD grid overlay
  final bool showGrid;

  /// The opacity of the grid lines (0.0 = transparent, 1.0 = opaque)
  final double gridOpacity;

  @override
  Widget build(BuildContext context) {
    return ShaderBuilder(
      (context, shader, child) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final size = Size(constraints.maxWidth, constraints.maxHeight);

            return AnimatedSampler(
              // Convert child widget to texture and pass to shader
              (ui.Image image, Size s, Canvas canvas) {
                // Calculate pixel count = screen width/height divided by block size
                final px = math.max(1.0, s.width / blockSize);
                final py = math.max(1.0, s.height / blockSize);

                // Set uniforms expected by flutter_shaders pixelation.frag
                shader
                  ..setFloat(0, px)           // X-direction pixel count
                  ..setFloat(1, py)           // Y-direction pixel count
                  ..setFloat(2, s.width)      // Drawing width
                  ..setFloat(3, s.height)     // Drawing height
                  ..setImageSampler(0, image); // Child widget texture

                // Draw shader across entire screen (pixelates the background)
                canvas.drawRect(Offset.zero & s, Paint()..shader = shader);

                // Optional: LCD-style grid overlay
                if (showGrid) {
                  final gridPaint = Paint()
                    ..color = Colors.black.withOpacity(gridOpacity)
                    ..strokeWidth = 1;

                  final cellW = s.width / px;
                  final cellH = s.height / py;

                  // Vertical lines
                  for (double x = 0; x <= s.width; x += cellW) {
                    canvas.drawLine(Offset(x, 0), Offset(x, s.height), gridPaint);
                  }
                  // Horizontal lines
                  for (double y = 0; y <= s.height; y += cellH) {
                    canvas.drawLine(Offset(0, y), Offset(s.width, y), gridPaint);
                  }
                }
              },
              child: child!,
            );
          },
        );
      },
      assetKey: 'packages/flutter_shaders/shaders/pixelation.frag',
      child: child,
    );
  }
}
