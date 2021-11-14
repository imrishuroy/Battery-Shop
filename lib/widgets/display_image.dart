import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

const String _errorImage =
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTjMD6Pl7n4lSFFphlDlRz7o4ULYlNrAC9KJN4sfz9mRDDgU_FzGrA-DNgLL8keHh90KJg&usqp=CAU';

class DisplayImage extends StatelessWidget {
  const DisplayImage({
    Key? key,
    required this.imageUrl,
    this.width,
    this.fit = BoxFit.cover,
  }) : super(key: key);

  final String? imageUrl;
  final double? width;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: width ?? 1000.0,
      height: double.infinity,
      imageUrl: imageUrl ?? _errorImage,
      fit: fit,
      progressIndicatorBuilder: (
        BuildContext context,
        String url,
        DownloadProgress downloadProgress,
      ) =>
          Center(
        child: CircularProgressIndicator(
          strokeWidth: 2.0,
          value: downloadProgress.progress,
        ),
      ),
      errorWidget: (_, __, ___) => const Center(child: Icon(Icons.error)),
    );
  }
}
