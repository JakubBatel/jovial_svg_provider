import 'dart:async';
import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:jovial_svg/jovial_svg.dart';
import 'package:jovial_svg_provider/src/image_source.dart';

typedef ImageLoader = FutureOr<ScalableImage> Function();

class ScalableImageKey with EquatableMixin {
  final String path;
  final ImageSource source;
  final int width;
  final int height;
  final double scale;
  final Color color;

  const ScalableImageKey({
    required this.path,
    required this.source,
    required this.scale,
    required this.color,
    required this.width,
    required this.height,
  });

  @override
  List<Object?> get props => [path, source, width, height, scale, color];
}
