import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CachedImage extends StatelessWidget {
  final String url;
  final double height;
  final double width;

  const CachedImage({
    super.key,
    required this.url,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: CachedNetworkImage(
        imageUrl: url,
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            SizedBox(height: 50, width: 50, child: CircularProgressIndicator(value: downloadProgress.progress),),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}
