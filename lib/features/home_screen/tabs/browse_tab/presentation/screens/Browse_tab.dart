import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/di/Di.dart';
import 'package:movies_app/features/home_screen/tabs/HomeTab/presentation/widget/moves_card.dart';
import 'package:movies_app/features/home_screen/tabs/HomeTab/presentation/cubit/movies_state.dart';
import 'package:movies_app/features/home_screen/tabs/HomeTab/presentation/cubit/movies_cubit.dart';

import '../../../../../movie_details/presentation/cubit/cubit_movie_details.dart';
import '../../../../../movie_details/presentation/cubit/fav_cubit/FavoriteCubit.dart';
import '../../../../../movie_details/presentation/screen/movie_details_screen.dart';
import '../widget/CategoryChipsBar.dart';
import '../../../profile_tab/history/presentation/cubit/history_cubit.dart';

class BrowseTab extends StatefulWidget {
  const BrowseTab({Key? key}) : super(key: key);

  @override
  State<BrowseTab> createState() => _BrowseTabState();
}

class _BrowseTabState extends State<BrowseTab> {
  static const int _pageLimit = 20;
  int _selectedChipIndex = 0;

  final List<String> _categories = [
    'All',
    'Action',
    'Adventure',
    'Animation',
    'Biography',
    'Comedy',
    'Crime'
  ];

  String _mapKey(String category) => category.toLowerCase();

  @override
  Widget build(BuildContext context) {
    final moviesCubit = getIt.get<MoviesCubit>();

    return BlocProvider(
      create: (_) {
        moviesCubit.getTopMovies();   // ← ← تم إصلاحها

        for (var cat in _categories) {
          if (cat.toLowerCase() != 'all') {
            moviesCubit.grtMoviesByGenre(10, _mapKey(cat));
          }
        }

        return moviesCubit;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: const Text("Browse", style: TextStyle(color: Colors.white)),
        ),
        body: Column(
          children: [
            CategoryChipsBar(
              categories: _categories,
              selectedIndex: _selectedChipIndex,
              onSelected: (index, category) {
                setState(() => _selectedChipIndex = index);
                final cubit = context.read<MoviesCubit>();

                if (category.toLowerCase() == "all") {
                  cubit.getTopMovies();   // ← اصلاح
                } else {
                  cubit.grtMoviesByGenre(_pageLimit, _mapKey(category));
                }
              },
            ),

            Expanded(
              child: BlocBuilder<MoviesCubit, MoviesState>(
                builder: (context, state) {
                  if (state is MoviesLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is MoviesError) {
                    return Center(
                      child: Text("Error: ${state.error}",
                          style: const TextStyle(color: Colors.white)),
                    );
                  }

                  if (state is MoviesSuccess) {
                    final category = _categories[_selectedChipIndex];
                    final movies = category.toLowerCase() == "all"
                        ? state.topMovies
                        : (state.genreMoviesMap[_mapKey(category)] ?? []);

                    return GridView.builder(
                      itemCount: movies.length,
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio: 1 / 1.3,
                      ),
                      itemBuilder: (_, i) {
                        final movie = movies[i];
                        return MovesCard(
                          posterPath: movie.image ?? "",
                          rating: movie.rating ?? 0.0,

                          /// تم إضافة onTap هنا
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => MultiBlocProvider(
                                  providers: [
                                    BlocProvider(
                                      create: (_) => getIt<CubitMovieDetails>()
                                        ..loadMovie(movie.id.toString()),
                                    ),
                                    BlocProvider(create: (_) => getIt<FavoriteCubit>()),
                                    BlocProvider.value(
                                      value: context.read<HistoryCubit>(),
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
          ],
        ),
      ),
    );
  }
}
