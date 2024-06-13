import 'package:flutter/material.dart';

class PreviewWithLabel extends StatelessWidget {
  final Widget preview;
  final String label;
  final double size;

  const PreviewWithLabel({super.key, required this.preview, required this.label, this.size = 128.0});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      child: Column(
        children: [
          SizedBox.square(
            dimension: size,
            child: Center(child: preview),
          ),
          const SizedBox(height: 8.0),
          Text(
            label,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
