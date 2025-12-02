import 'package:flutter/material.dart';
import 'package:movies_app/features/home_screen/tabs/HomeTab/domain/model/movie.dart';
import 'package:movies_app/features/home_screen/tabs/HomeTab/presentation/widget/moves_card.dart';

class CategorySection extends StatelessWidget {
  final String title;
  final List<Movie> movies;
  final VoidCallback? onSeeMore;

  const CategorySection({
    Key? key,
    required this.title,
    required this.movies,
    this.onSeeMore,
  }) : super(key: key);

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

              InkWell(
                onTap: onSeeMore,
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                  child: Text(
                    "See More →",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
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
              final movie = movies[index];

              return MovesCard(
                posterPath: movie.image ?? "",
                rating: movie.rating ?? 0.0,
                onTap: () {
                },
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
