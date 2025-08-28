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
  const PixelateWidget({
    super.key,
    required this.child,
    this.blockSize = 6.0,
  });

  /// The child widget to apply the pixel effect to
  final Widget child;

  /// The size of each pixel block (larger = more pixelated)
  /// 
  /// Recommended range: 0.5 to 20.0
  final double blockSize;

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
