import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomHallImage extends StatelessWidget {
  const CustomHallImage({super.key, required this.image});
  final String image;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: image,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: AspectRatio(
          aspectRatio: 3 / 2,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) {
                return const Icon(Icons.error);
              },
              imageUrl:  image,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
