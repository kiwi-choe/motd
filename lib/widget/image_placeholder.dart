import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class ImagePlaceholder extends StatelessWidget {
  const ImagePlaceholder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.memory(kTransparentImage),
    );
  }
}
