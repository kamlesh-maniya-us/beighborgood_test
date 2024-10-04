import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:neighborgood/_core/constant/string_constants.dart';

class CustomImage extends StatelessWidget {
  final String imageUrl;
  const CustomImage({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(36),
      child: CachedNetworkImage(
        imageUrl: imageUrl.isEmpty ? StringConstants.staticUserImage : imageUrl,
      ),
    );
  }
}
