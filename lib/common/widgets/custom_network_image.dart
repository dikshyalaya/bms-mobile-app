import 'package:flutter/material.dart';

class CustomNetworkImage extends StatelessWidget {
  final String? accessToken;
  final double? height;
  final double? width;
  final String? imageUrl;
  final Widget? errorWidget;

  const CustomNetworkImage({
    Key? key,
    this.accessToken,
    this.height,
    this.width,
    this.imageUrl,
    this.errorWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 34,
      width: width ?? 34,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Image.network(
        imageUrl ?? '',
        // headers: {"Authorization": "Bearer $accessToken"},
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return errorWidget ?? const Icon(Icons.error);
        },
      ),
    );
  }
}
