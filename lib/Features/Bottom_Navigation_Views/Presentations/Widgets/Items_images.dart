// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:hash_cached_image/hash_cached_image.dart';

class ItemsImages extends StatelessWidget {
  const ItemsImages({
    super.key,
    this.borderRadius,
    required this.imageUrl,
    this.aspectRatio = 1,
    this.fit = BoxFit.fill,
  });
  final double? borderRadius;
  final String imageUrl;
  final double aspectRatio;
  final BoxFit fit;
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius ?? 0),
        child: HashCachedImage(
          imageUrl: imageUrl,
          fit: fit,
          errorWidget: (context, url, error) => const Icon(
            Icons.error,
            size: 30,
            color: Colors.yellow,
          ),
        ),
      ),
    );
  }
}
