import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CircleCachedNetworkImage extends StatelessWidget {
  final String imageUrl;
  final Widget? placeholder;
  final Widget? errorWidget;
  const CircleCachedNetworkImage(
      {Key? key, required this.imageUrl, this.placeholder, this.errorWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (context, url) => const CircularProgressIndicator(),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
