import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:jovial_svg/jovial_svg.dart';
import 'package:jovial_svg_provider/src/image_source.dart';
import 'package:jovial_svg_provider/src/image_type.dart';
import 'package:jovial_svg_provider/src/scalable_image_key.dart';

class ScalableImageProvider extends ImageProvider<ScalableImageKey> {
  final String path;
  final ImageSource source;
  final ImageType type;
  final Size? size;
  final double? scale;
  final Color? color;

  const ScalableImageProvider(
    this.path, {
    this.source = ImageSource.asset,
    this.type = ImageType.svg,
    this.size,
    this.scale,
    this.color,
  });

  @override
  Future<ScalableImageKey> obtainKey(ImageConfiguration configuration) {
    final scale = this.scale ?? configuration.devicePixelRatio ?? 1.0;
    final logicWidth = size?.width ?? configuration.size?.width ?? 100;
    final logicHeight = size?.height ?? configuration.size?.width ?? 100;

    return SynchronousFuture(
      ScalableImageKey(
        path: path,
        source: source,
        scale: scale,
        color: color ?? const Color(0x00000000),
        width: (logicWidth * scale).ceil(),
        height: (logicHeight * scale).ceil(),
      ),
    );
  }

  @override
  ImageStreamCompleter loadImage(ScalableImageKey key, ImageDecoderCallback decode) {
    return OneFrameImageStreamCompleter(_loadSvg(key));
  }

  Future<ImageInfo> _loadSvg(ScalableImageKey key) async {
    final si = await _imageLoader.call();

    final recorder = PictureRecorder();
    final canvas = Canvas(recorder);

    ScalingTransform(
      containerSize: Size(key.width.toDouble(), key.height.toDouble()),
      siViewport: si.viewport,
      fit: BoxFit.contain,
      alignment: Alignment.center,
    ).applyToCanvas(canvas);
    si.paint(canvas);

    final picture = recorder.endRecording();
    final image = await picture.toImage(key.width, key.height);

    return ImageInfo(image: image, scale: key.scale);
  }

  ImageLoader get _imageLoader {
    switch (type) {
      case ImageType.avd:
        return _avdLoader;
      case ImageType.si:
        return _siLoader;
      case ImageType.svg:
        return _svgLoader;
    }
  }

  ImageLoader get _avdLoader {
    switch (source) {
      case ImageSource.asset:
        return () => ScalableImage.fromAvdAsset(rootBundle, path);
      case ImageSource.file:
        return () => ScalableImage.fromAvdString(File(path).readAsStringSync());
      case ImageSource.network:
        return () => ScalableImage.fromAvdHttpUrl(Uri.parse(path));
    }
  }

  ImageLoader get _siLoader {
    switch (source) {
      case ImageSource.asset:
        return () => ScalableImage.fromSIAsset(rootBundle, path);
      case ImageSource.file:
        return () => ScalableImage.fromSIBytes(File(path).readAsBytesSync());
      case ImageSource.network:
        throw UnsupportedError('SI images can not be loaded from network.');
    }
  }

  ImageLoader get _svgLoader {
    switch (source) {
      case ImageSource.asset:
        return () => ScalableImage.fromSvgAsset(rootBundle, path);
      case ImageSource.file:
        return () => ScalableImage.fromSvgString(File(path).readAsStringSync());
      case ImageSource.network:
        return () => ScalableImage.fromSvgHttpUrl(Uri.parse(path));
    }
  }
}
