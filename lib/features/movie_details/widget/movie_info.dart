import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movies_app/core/config/app_colors.dart';

class MovieInfo extends StatelessWidget {
  final String? poster;
  final String name;
  final String year;
  final bool isFavorite; 
  final VoidCallback? onFavoriteTap;

  const MovieInfo({
    super.key,
    this.poster,
    required this.name,
    required this.year,
    required this.onFavoriteTap,  this.isFavorite= false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 600,
          width: double.infinity,
          foregroundDecoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                AppColors.eerieBlack.withValues(alpha: 0.4),
                AppColors.eerieBlack,
              ],
            ),
          ),
          child: CachedNetworkImage(
            imageUrl: (poster?.isNotEmpty ?? false) ? poster! : "about:blank",
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

        InkWell(
          onTap: () {},
          child: Image.asset(
            "assets/images/play_icn.png",
            width: 97,
            height: 97,
          ),
        ),

        Positioned(
          top: 10,
          left: 5,
          right: 5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  size: 29,
                  color: AppColors.white,
                ),
              ),
              IconButton(
                onPressed: onFavoriteTap,
                icon: Icon(
                  isFavorite
                      ? Icons.bookmark      
                      : Icons.bookmark_outline_outlined, 
                  size: 29,
                  color: AppColors.white,
                ),
              ),
            ],
          ),
        ),

        // Movie info (title + year)
        Positioned(
          bottom: 20,
          left: 20,
          right: 20,
          child: Column(
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 20),
              Text(
                year,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
