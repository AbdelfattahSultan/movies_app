import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movies_app/features/home_screen/tabs/HomeTab/presentation/widget/RatingBadge.dart';

class MovesCard extends StatelessWidget {
  final String posterPath;
  final double rating;

  const MovesCard({
    super.key,
    required this.posterPath,
    this.rating = 7.7,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width * 0.3,
      height: size.height * 0.22,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Stack(
          children: [
            CachedNetworkImage(
              imageUrl: posterPath,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              placeholder: (context, url) =>
                  Container(
                    color: Colors.grey[300],
                    child: const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
              errorWidget: (context, url, error) =>
                  Container(
                    color: Colors.grey[300],
                    child: const Icon(Icons.error, color: Colors.red),
                  ),
            ),

            Positioned(
              top: 6,
              left: 6,
              child: RatingBadge(rating: rating),
            ),
          ],
        ),
      ),
    );
  }
}
