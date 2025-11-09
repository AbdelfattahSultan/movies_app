import 'package:flutter/material.dart';
import 'package:movies_app/features/HomeTab/domain/model/movie.dart';
import 'package:movies_app/features/HomeTab/presentation/widget/moves_card.dart';

class CategorySection extends StatelessWidget {
  final String title;
  final List<Movie> movies;
  const CategorySection({
    super.key,
    required this.title,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "See More →",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: size.height * 0.25,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (context, index) {
              return MovesCard(
                posterPath: movies[index].image,
                rating: movies[index].rating,
              );
            },
            separatorBuilder: (context, index) => const SizedBox(width: 10),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
