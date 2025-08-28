import 'package:flutter/material.dart';
import 'package:pixelate/pixelate.dart';

class RgbSubpixelDemo extends StatefulWidget {
  const RgbSubpixelDemo({super.key});

  @override
  State<RgbSubpixelDemo> createState() => _RgbSubpixelDemoState();
}

class _RgbSubpixelDemoState extends State<RgbSubpixelDemo> {
  PixelateEffect effect = const PixelateEffect(
    blockSize: 8.0,
    showGrid: true,
    gridOpacity: 0.08,
    enableRgbSubpixels: true,
    subpixelIntensity: 1.0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RGB Subpixel Demo'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: Column(
        children: [
          // Controls
          Card(
            margin: const EdgeInsets.all(16),
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
          
          // Demo content with RGB subpixel effect
          Expanded(
            child: PixelateContainer(
              effect: effect,
              child: _buildDemoContent(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDemoContent() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'RGB Subpixel Effect Demo',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          
          const Text(
            'This demonstrates the RGB subpixel structure of LCD displays. Each pixel is divided into red, green, and blue vertical strips, similar to real LCD monitors.',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 24),
          
          // Color gradient demo
          Container(
            height: 100,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.red,
                  Colors.orange,
                  Colors.yellow,
                  Colors.green,
                  Colors.blue,
                  Colors.indigo,
                  Colors.purple,
                ],
              ),
            ),
            alignment: Alignment.center,
            child: const Text(
              'COLOR GRADIENT',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                shadows: [
                  Shadow(
                    offset: Offset(1, 1),
                    blurRadius: 2,
                    color: Colors.black54,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          
          // Text demo
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'LCD TEXT DISPLAY',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.greenAccent,
                    fontFamily: 'monospace',
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'The RGB subpixel effect simulates how LCD displays work at the hardware level.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.green,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          
          // Colorful boxes demo
          const Text(
            'Color Intensity Test:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _buildColorBox('RED', Colors.red),
              _buildColorBox('GREEN', Colors.green),
              _buildColorBox('BLUE', Colors.blue),
              _buildColorBox('CYAN', Colors.cyan),
              _buildColorBox('MAGENTA', const Color(0xFFFF00FF)),
              _buildColorBox('YELLOW', Colors.yellow),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildColorBox(String label, Color color) {
    return Container(
      width: 100,
      height: 80,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w900,
          color: Colors.white,
          shadows: [
            Shadow(
              offset: Offset(1, 1),
              blurRadius: 2,
              color: Colors.black54,
            ),
          ],
        ),
      ),
    );
  }
}
