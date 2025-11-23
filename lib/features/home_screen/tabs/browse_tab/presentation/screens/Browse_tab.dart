import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/di/Di.dart';
import 'package:movies_app/features/home_screen/tabs/HomeTab/presentation/widget/moves_card.dart';
import 'package:movies_app/features/home_screen/tabs/HomeTab/presentation/cubit/movies_state.dart';
import 'package:movies_app/features/home_screen/tabs/HomeTab/presentation/cubit/movies_cubit.dart';
import 'package:movies_app/features/home_screen/tabs/HomeTab/domain/model/movie.dart';
import 'package:movies_app/features/movie_details/presentation/cubit/cubit_movie_details.dart';
import 'package:movies_app/features/movie_details/presentation/cubit/fav_cubit/FavoriteCubit.dart';
import 'package:movies_app/features/movie_details/presentation/screen/movie_details_screen.dart';

import '../widget/CategoryChipsBar.dart';

class BrowseTab extends StatefulWidget {
  const BrowseTab({Key? key}) : super(key: key);

  @override
  State<BrowseTab> createState() => _BrowseTabState();
}

class _BrowseTabState extends State<BrowseTab> {
  static const int _pageLimit = 20;
  int _selectedChipIndex = 0;

  final List<String> _categories = [
    'Action',
    'Adventure',
    'Animation',
    'Biography',
    'Comedy',
    'Crime',
  ];

  String _mapKey(String category) => category.toLowerCase();

  @override
  Widget build(BuildContext context) {
    final moviesCubitFromDi = getIt.get<MoviesCubit>();

    return BlocProvider<MoviesCubit>(
      create: (context) {
        moviesCubitFromDi.grtMoviesByGenre(
          _pageLimit,
          _mapKey(_categories.first),
        );

        return moviesCubitFromDi;
      },

      child: Builder(
        builder: (context) {
          return Scaffold(
            body: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  CategoryChipsBar(
                    categories: _categories,
                    selectedIndex: _selectedChipIndex,
                    onSelected: (index, category) {
                      setState(() => _selectedChipIndex = index);

                      final cubit = context.read<MoviesCubit>();

                      cubit.grtMoviesByGenre(_pageLimit, _mapKey(category));
                    },
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      child: BlocBuilder<MoviesCubit, MoviesState>(
                        buildWhen: (previous, current) {
                          return current is MoviesLoading ||
                              current is MoviesSuccess ||
                              current is MoviesError;
                        },
                        builder: (context, state) {
                          if (state is MoviesLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (state is MoviesError) {
                            return Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Error: ${state.error}',
                                    style: const TextStyle(
                                      color: Colors.white70,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  ElevatedButton(
                                    onPressed: () {
                                      final cubit = context.read<MoviesCubit>();
                                      final current =
                                          _categories[_selectedChipIndex];

                                      cubit.grtMoviesByGenre(
                                        _pageLimit,
                                        _mapKey(current),
                                      );
                                    },
                                    child: const Text('Retry'),
                                  ),
                                ],
                              ),
                            );
                          }

                          if (state is MoviesSuccess) {
                            final current = _categories[_selectedChipIndex];

                            final List<Movie> movies =
                                state.genreMoviesMap[_mapKey(current)] ?? [];

                            if (movies.isEmpty) {
                              return const Center(
                                child: Text(
                                  'No movies found',
                                  style: TextStyle(color: Colors.white70),
                                ),
                              );
                            }

                            return GridView.builder(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemCount: movies.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 11,
                                    mainAxisSpacing: 11,
                                    childAspectRatio: 1 / 1.3,
                                  ),
                              itemBuilder: (context, index) {
                                final Movie movie = movies[index];
                                return MovesCard(
                                  posterPath: movie.image ?? '',
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
                                                    ..loadMovie(
                                                      movie.id.toString(),
                                                    ),
                                            ),
                                            BlocProvider(
                                              create: (_) =>
                                                  getIt<FavoriteCubit>(),
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
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
