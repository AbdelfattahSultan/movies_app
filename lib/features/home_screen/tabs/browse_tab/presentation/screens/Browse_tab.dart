import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/home_screen/tabs/HomeTab/presentation/cubit/movies_cubit.dart';
import 'package:movies_app/features/home_screen/tabs/HomeTab/presentation/cubit/movies_state.dart';
import 'package:movies_app/features/home_screen/tabs/HomeTab/domain/model/movie.dart';
import 'package:movies_app/features/home_screen/tabs/HomeTab/presentation/widget/moves_card.dart';
import 'package:movies_app/features/home_screen/tabs/profile_tab/presentation/cubit/history/history_cubit.dart';
import 'package:movies_app/features/movie_details/presentation/cubit/cubit_movie_details.dart';
import 'package:movies_app/features/movie_details/presentation/cubit/fav_cubit/FavoriteCubit.dart';
import 'package:movies_app/features/movie_details/presentation/screen/movie_details_screen.dart';
import 'package:movies_app/core/di/Di.dart';
import '../widget/CategoryChipsBar.dart';

class BrowseTab extends StatefulWidget {
  final int initialIndex;

  const BrowseTab({super.key, this.initialIndex = 0});

  @override
  State<BrowseTab> createState() => _BrowseTabState();
}

class _BrowseTabState extends State<BrowseTab> {
  final categories = ["Action", "Adventure", "Comedy", "Crime"];

  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.only(top: 12),
        child: Column(
          children: [
            CategoryChipsBar(
              categories: categories,
              selectedIndex: selectedIndex,
              onSelected: (i, c) {
                setState(() => selectedIndex = i);
              },
            ),

            Expanded(
              child: BlocBuilder<MoviesCubit, MoviesState>(
                builder: (_, state) {
                  if (state is MoviesLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is MoviesSuccess) {
                    final genre = categories[selectedIndex].toLowerCase();
                    final List<Movie> movies =
                        state.genreMoviesMap[genre] ?? [];

                    if (movies.isEmpty) {
                      return const Center(
                        child: Text(
                          "No movies found",
                          style: TextStyle(color: Colors.white70),
                        ),
                      );
                    }

                    return GridView.builder(
                      padding: const EdgeInsets.all(12),
                      itemCount: movies.length,
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: 1 / 1.35,
                      ),
                      itemBuilder: (_, index) {
                        final movie = movies[index];
                        return MovesCard(
                          posterPath: movie.image ?? "",
                          rating: movie.rating ?? 0.0,
                          onTap: () {
                            context.read<HistoryCubit>().addMovie(movie);

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => MultiBlocProvider(
                                  providers: [
                                    BlocProvider(
                                      create: (_) => getIt<CubitMovieDetails>()
                                        ..loadMovie(movie.id.toString()),
                                    ),
                                    BlocProvider(
                                      create: (_) => getIt<FavoriteCubit>(),
                                    ),
                                  ],
                                  child: const MovieDetailsScreen(),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  }

                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
