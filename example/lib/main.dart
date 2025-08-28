import 'package:flutter/material.dart';
import 'package:flutter_pixelate/flutter_pixelate.dart';

void main() {
  runApp(const PixelateExampleApp());
}

class PixelateExampleApp extends StatelessWidget {
  const PixelateExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pixelate Example',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.deepPurple,
      ),
      home: const PixelateExampleHome(),
    );
  }
}

class PixelateExampleHome extends StatefulWidget {
  const PixelateExampleHome({super.key});

  @override
  State<PixelateExampleHome> createState() => _PixelateExampleHomeState();
}

class _PixelateExampleHomeState extends State<PixelateExampleHome> {
  PixelateEffect effect = PixelateEffect.medium;

  @override
  Widget build(BuildContext context) {
    // Demo content to show the effect
    final content = Scaffold(
      appBar: AppBar(title: const Text('Pixelate Plugin Demo')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Pixelate Effect Demo',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          
          // Controls section
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: PixelateControls(
                effect: effect,
                onEffectChanged: (newEffect) {
                  setState(() {
                    effect = newEffect;
                  });
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
          
          // Demo content section
          const Text(
            'Demo Content',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          
          // Action button
          FilledButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Button pressed with pixel effect!')),
              );
            },
            icon: const Icon(Icons.auto_awesome),
            label: const Text('Demo Action'),
          ),
          const SizedBox(height: 16),
          
          // Sample cards
          const Text('Sample Cards:', style: TextStyle(fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: List.generate(6, (i) {
              return Container(
                width: 160,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    colors: [
                      Colors.primaries[i * 2 % Colors.primaries.length],
                      Colors.primaries[(i * 2 + 1) % Colors.primaries.length],
                    ],
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  'PIXEL ${i + 1}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 600),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          setState(() {
            effect = effect.copyWith(enabled: !effect.enabled);
          });
        },
        label: Text(effect.enabled ? 'Disable Effect' : 'Enable Effect'),
        icon: Icon(effect.enabled ? Icons.visibility_off : Icons.visibility),
      ),
    );

    // Apply the effect if enabled
    return PixelateContainer(
      effect: effect,
      child: content,
    );
  }
}
