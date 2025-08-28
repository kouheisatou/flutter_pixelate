import 'package:flutter/material.dart';
import 'pixelate_effect.dart';
import 'pixelate_widget.dart';

/// A convenience widget that applies Pixelate effect with a PixelateEffect configuration
class PixelateContainer extends StatelessWidget {
  /// Creates a PixelateContainer
  const PixelateContainer({
    super.key,
    required this.child,
    this.effect = PixelateEffect.medium,
  });

  /// The child widget to apply the effect to
  final Widget child;

  /// The effect configuration
  final PixelateEffect effect;

  @override
  Widget build(BuildContext context) {
    if (!effect.enabled) {
      return child;
    }

    return PixelateWidget(
      blockSize: effect.blockSize,
      showGrid: effect.showGrid,
      gridOpacity: effect.gridOpacity,
      child: child,
    );
  }
}

/// A widget that provides controls for adjusting Pixelate effects
class PixelateControls extends StatelessWidget {
  /// Creates PixelateControls
  const PixelateControls({
    super.key,
    required this.effect,
    required this.onEffectChanged,
    this.showTitle = true,
    this.minBlockSize = 2.0,
    this.maxBlockSize = 20.0,
  });

  /// Current effect configuration
  final PixelateEffect effect;

  /// Callback when effect changes
  final ValueChanged<PixelateEffect> onEffectChanged;

  /// Whether to show the title
  final bool showTitle;

  /// Minimum block size for the slider
  final double minBlockSize;

  /// Maximum block size for the slider
  final double maxBlockSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showTitle)
          const Text(
            'Pixelate Effect',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        if (showTitle) const SizedBox(height: 8),
        
        // Block Size Slider
        Row(
          children: [
            const Text('Pixel Size'),
            Expanded(
              child: Slider(
                min: minBlockSize,
                max: maxBlockSize,
                value: effect.blockSize,
                onChanged: (value) {
                  onEffectChanged(effect.copyWith(blockSize: value));
                },
              ),
            ),
            Text('${effect.blockSize.toStringAsFixed(0)}'),
          ],
        ),
        
        // Grid Toggle
        SwitchListTile(
          title: const Text('LCD Grid'),
          subtitle: const Text('Show retro LCD grid lines'),
          value: effect.showGrid,
          onChanged: (value) {
            onEffectChanged(effect.copyWith(showGrid: value));
          },
          contentPadding: EdgeInsets.zero,
        ),
        
        // Grid Opacity Slider (only when grid is enabled)
        if (effect.showGrid)
          Row(
            children: [
              const Text('Grid Opacity'),
              Expanded(
                child: Slider(
                  min: 0.0,
                  max: 0.2,
                  value: effect.gridOpacity,
                  onChanged: (value) {
                    onEffectChanged(effect.copyWith(gridOpacity: value));
                  },
                ),
              ),
              Text('${(effect.gridOpacity * 100).toStringAsFixed(0)}%'),
            ],
          ),
        
        // Preset Buttons
        const SizedBox(height: 8),
        const Text('Presets:', style: TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 4),
        Wrap(
          spacing: 8,
          children: [
            _PresetButton(
              label: 'Smooth',
              effect: PixelateEffect.smooth,
              currentEffect: effect,
              onPressed: onEffectChanged,
            ),
            _PresetButton(
              label: 'Medium',
              effect: PixelateEffect.medium,
              currentEffect: effect,
              onPressed: onEffectChanged,
            ),
            _PresetButton(
              label: 'Retro',
              effect: PixelateEffect.retro,
              currentEffect: effect,
              onPressed: onEffectChanged,
            ),
            _PresetButton(
              label: 'Vintage',
              effect: PixelateEffect.vintage,
              currentEffect: effect,
              onPressed: onEffectChanged,
            ),
          ],
        ),
      ],
    );
  }
}

class _PresetButton extends StatelessWidget {
  const _PresetButton({
    required this.label,
    required this.effect,
    required this.currentEffect,
    required this.onPressed,
  });

  final String label;
  final PixelateEffect effect;
  final PixelateEffect currentEffect;
  final ValueChanged<PixelateEffect> onPressed;

  @override
  Widget build(BuildContext context) {
    final isSelected = effect == currentEffect;
    
    return FilledButton.tonal(
      onPressed: () => onPressed(effect),
      style: FilledButton.styleFrom(
        backgroundColor: isSelected 
            ? Theme.of(context).colorScheme.primary
            : null,
        foregroundColor: isSelected 
            ? Theme.of(context).colorScheme.onPrimary
            : null,
      ),
      child: Text(label),
    );
  }
}
