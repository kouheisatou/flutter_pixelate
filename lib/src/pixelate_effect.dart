import 'package:flutter/material.dart';

/// Configuration class for Pixelate effects
/// 
/// This class holds all the settings for customizing the retro pixel effect.
class PixelateEffect {
  /// Creates a PixelateEffect configuration
  const PixelateEffect({
    this.blockSize = 6.0,
    this.enabled = true,
  });

  /// The size of each pixel block (larger = more pixelated)
  /// 
  /// Recommended range: 0.5 to 20.0
  /// Default: 6.0
  final double blockSize;

  /// Whether the effect is enabled
  /// 
  /// Default: true
  final bool enabled;

  /// Creates a copy of this effect with the given fields replaced
  PixelateEffect copyWith({
    double? blockSize,
    bool? enabled,
  }) {
    return PixelateEffect(
      blockSize: blockSize ?? this.blockSize,
      enabled: enabled ?? this.enabled,
    );
  }

  /// Creates an effect with ultra-fine pixelation
  static const PixelateEffect ultraFine = PixelateEffect(
    blockSize: 0.5,
  );

  /// Creates an effect with fine pixelation
  static const PixelateEffect fine = PixelateEffect(
    blockSize: 1.0,
  );

  /// Creates an effect with low pixelation (smooth)
  static const PixelateEffect smooth = PixelateEffect(
    blockSize: 3.0,
  );

  /// Creates an effect with medium pixelation
  static const PixelateEffect medium = PixelateEffect(
    blockSize: 6.0,
  );

  /// Creates an effect with high pixelation (retro)
  static const PixelateEffect retro = PixelateEffect(
    blockSize: 12.0,
  );

  /// Creates an effect with extreme pixelation (vintage)
  static const PixelateEffect vintage = PixelateEffect(
    blockSize: 20.0,
  );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PixelateEffect &&
        other.blockSize == blockSize &&
        other.enabled == enabled;
  }

  @override
  int get hashCode {
    return Object.hash(
      blockSize,
      enabled,
    );
  }

  @override
  String toString() {
    return 'PixelateEffect('
        'blockSize: $blockSize, '
        'enabled: $enabled)';
  }
}
