import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movies_app/features/home_screen/tabs/HomeTab/presentation/widget/RatingBadge.dart';

class CarouselCard extends StatelessWidget {
  final String image;
  final double rating;
  final VoidCallback onTap;

  const CarouselCard({
    super.key,
    required this.image,
    required this.rating,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return InkWell(
      onTap: onTap,
      child: Container(
        width: size.width,
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: [
              CachedNetworkImage(
                imageUrl: image,
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) =>
                    const Icon(Icons.error, color: Colors.red),
              ),

              Positioned(top: 12, left: 12, child: RatingBadge(rating: rating)),
            ],
          ),
        ),
      ),
    );
  }
}
