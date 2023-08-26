import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageViewer extends StatelessWidget {
  final ImageProvider<Object>? imageProvider;
  final Widget Function(BuildContext, ImageChunkEvent?)? loadingBuilder;
  const ImageViewer({super.key, this.imageProvider, this.loadingBuilder});

  @override
  Widget build(BuildContext context) {
    return PhotoView(
      imageProvider: imageProvider,
      loadingBuilder: loadingBuilder,
    );
  }
}
