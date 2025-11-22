import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/di/Di.dart';
import 'package:movies_app/features/home_screen/tabs/HomeTab/domain/model/movie.dart';
import 'package:movies_app/features/home_screen/tabs/HomeTab/presentation/widget/moves_card.dart';
import 'package:movies_app/features/movie_details/presentation/cubit/cubit_movie_details.dart';
import 'package:movies_app/features/movie_details/presentation/cubit/fav_cubit/FavoriteCubit.dart';
import 'package:movies_app/features/movie_details/presentation/screen/movie_details_screen.dart';

class CategorySection extends StatelessWidget {
  final String title;
  final List<Movie> movies;

  const CategorySection({super.key, required this.title, required this.movies});

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
                style: const TextStyle(color: Colors.blue, fontSize: 16),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MultiBlocProvider(
                        providers: [
                          BlocProvider(
                            create: (_) =>
                                getIt<CubitMovieDetails>()
                                  ..loadMovie(movies[index].id.toString()),
                          ),
                          BlocProvider(create: (_) => getIt<FavoriteCubit>()),
                        ],
                        child: const MovieDetailsScreen(),
                      ),
                    ),
                  );
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
