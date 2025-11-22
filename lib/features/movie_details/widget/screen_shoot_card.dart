import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movies_app/core/config/app_colors.dart';

class ScreenShootCard extends StatelessWidget {
  final String? imagePath;

  const ScreenShootCard({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 13),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: CachedNetworkImage(
          imageUrl: (imagePath?.isNotEmpty ?? false)
              ? imagePath!
              : "about:blank",
          width: 246,
          height: 138,
          fit: BoxFit.cover,

          placeholder: (context, url) =>
              const Center(child: CircularProgressIndicator()),

          errorWidget: (context, url, error) {
            return const Center(
              child: Icon(
                Icons.image_not_supported,
                size: 50,
                color: AppColors.white,
              ),
            );
          },
        ),
      ),
    );
  }
}
