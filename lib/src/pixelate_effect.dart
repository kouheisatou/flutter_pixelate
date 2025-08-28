import 'package:flutter/material.dart';

/// Configuration class for Pixelate effects
/// 
/// This class holds all the settings for customizing the retro pixel effect.
class PixelateEffect {
  /// Creates a PixelateEffect configuration
  const PixelateEffect({
    this.blockSize = 6.0,
    this.showGrid = true,
    this.gridOpacity = 0.06,
    this.gridColor = Colors.black,
    this.enabled = true,
  });

  /// The size of each pixel block (larger = more pixelated)
  /// 
  /// Recommended range: 2.0 to 20.0
  /// Default: 6.0
  final double blockSize;

  /// Whether to show the LCD grid overlay
  /// 
  /// Default: true
  final bool showGrid;

  /// The opacity of the grid lines (0.0 = transparent, 1.0 = opaque)
  /// 
  /// Default: 0.06
  final double gridOpacity;

  /// The color of the grid lines
  /// 
  /// Default: Colors.black
  final Color gridColor;

  /// Whether the effect is enabled
  /// 
  /// Default: true
  final bool enabled;

  /// Creates a copy of this effect with the given fields replaced
  PixelateEffect copyWith({
    double? blockSize,
    bool? showGrid,
    double? gridOpacity,
    Color? gridColor,
    bool? enabled,
  }) {
    return PixelateEffect(
      blockSize: blockSize ?? this.blockSize,
      showGrid: showGrid ?? this.showGrid,
      gridOpacity: gridOpacity ?? this.gridOpacity,
      gridColor: gridColor ?? this.gridColor,
      enabled: enabled ?? this.enabled,
    );
  }

  /// Creates an effect with low pixelation (smooth)
  static const PixelateEffect smooth = PixelateEffect(
    blockSize: 3.0,
    showGrid: false,
  );

  /// Creates an effect with medium pixelation
  static const PixelateEffect medium = PixelateEffect(
    blockSize: 6.0,
    showGrid: true,
  );

  /// Creates an effect with high pixelation (retro)
  static const PixelateEffect retro = PixelateEffect(
    blockSize: 12.0,
    showGrid: true,
    gridOpacity: 0.08,
  );

  /// Creates an effect with extreme pixelation (vintage)
  static const PixelateEffect vintage = PixelateEffect(
    blockSize: 20.0,
    showGrid: true,
    gridOpacity: 0.1,
  );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PixelateEffect &&
        other.blockSize == blockSize &&
        other.showGrid == showGrid &&
        other.gridOpacity == gridOpacity &&
        other.gridColor == gridColor &&
        other.enabled == enabled;
  }

  @override
  int get hashCode {
    return Object.hash(
      blockSize,
      showGrid,
      gridOpacity,
      gridColor,
      enabled,
    );
  }

  @override
  String toString() {
    return 'PixelateEffect('
        'blockSize: $blockSize, '
        'showGrid: $showGrid, '
        'gridOpacity: $gridOpacity, '
        'gridColor: $gridColor, '
        'enabled: $enabled)';
  }
}
