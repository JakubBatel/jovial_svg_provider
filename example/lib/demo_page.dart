import 'package:example/preview_with_label.dart';
import 'package:flutter/material.dart';
import 'package:jovial_svg_provider/jovial_svg_provider.dart';

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.inversePrimary,
        title: Text('Jovial SVG Provider Demo'),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'SVG Provider used with Image',
                  style: theme.textTheme.titleMedium,
                ),
                const Wrap(
                  spacing: 16.0,
                  runSpacing: 16.0,
                  children: [
                    PreviewWithLabel(
                      preview: Image(
                        image: ScalableImageProvider(
                          'assets/image.svg',
                          source: ImageSource.asset,
                          type: ImageType.svg,
                        ),
                      ),
                      label: 'SVG from Assets',
                    ),
                    PreviewWithLabel(
                      preview: Image(
                        image: ScalableImageProvider(
                          'assets/image.si',
                          source: ImageSource.asset,
                          type: ImageType.si,
                        ),
                      ),
                      label: 'SI from Assets',
                    ),
                    PreviewWithLabel(
                      preview: Image(
                        image: ScalableImageProvider(
                          'https://svgsilh.com/svg/1295198-607d8b.svg',
                          source: ImageSource.network,
                          type: ImageType.svg,
                        ),
                      ),
                      label: 'SVG from network',
                    ),
                  ],
                ),
                const SizedBox(height: 64.0),
                Text(
                  'SVG Provider used with ImageIcon',
                  style: theme.textTheme.titleMedium,
                ),
                const Wrap(
                  spacing: 16.0,
                  runSpacing: 16.0,
                  children: [
                    PreviewWithLabel(
                      size: 72.0,
                      preview: ImageIcon(
                        ScalableImageProvider(
                          'assets/icon.svg',
                          source: ImageSource.asset,
                          type: ImageType.svg,
                        ),
                      ),
                      label: 'SVG from Assets',
                    ),
                    PreviewWithLabel(
                      size: 72.0,
                      preview: ImageIcon(
                        ScalableImageProvider(
                          'assets/icon.si',
                          source: ImageSource.asset,
                          type: ImageType.si,
                        ),
                      ),
                      label: 'SI from Assets',
                    ),
                    PreviewWithLabel(
                      size: 72.0,
                      preview: ImageIcon(
                        ScalableImageProvider(
                          'https://svgsilh.com/svg/308936.svg',
                          source: ImageSource.network,
                          type: ImageType.svg,
                        ),
                      ),
                      label: 'SVG from network',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
