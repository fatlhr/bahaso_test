import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({super.key, required this.url});
  final String url;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return SizedBox(
      height: size.height / 3,
      child: CachedNetworkImage(
        fit: BoxFit.fitWidth,
        imageUrl: url,
        // imageUrl: "http://via.placeholder.com/350x150",
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.contain,
            ),
          ),
        ),
        placeholder: (context, url) => Container(color: Colors.grey),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}
