// lib/features/home_screen/tabs/HomeTab/presentation/browse_tab.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/di/Di.dart';
import 'package:movies_app/features/home_screen/tabs/HomeTab/presentation/widget/moves_card.dart';
import 'package:movies_app/features/home_screen/tabs/HomeTab/presentation/cubit/movies_state.dart';
import 'package:movies_app/features/home_screen/tabs/HomeTab/presentation/cubit/movies_cubit.dart';
import 'package:movies_app/features/home_screen/tabs/HomeTab/domain/model/movie.dart';

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
    'All',
    'Action',
    'Adventure',
    'Animation',
    'Biography',
    'Comedy',
    'Crime'
  ];

  // helper to convert category label to key used in genreMoviesMap
  String _mapKey(String category) => category.toLowerCase();

  @override
  Widget build(BuildContext context) {
    // get cubit instance from DI (but do NOT call context.read here)
    final moviesCubitFromDi = getIt.get<MoviesCubit>();

    return BlocProvider<MoviesCubit>(
      create: (context) {
        // request initial data safely here
        // for "All" we fetch top movies; for some common genres we can prefetch (optional)
        moviesCubitFromDi.getTopMovies(_pageLimit, ""); // fill topMovies

        // prefetch a few genres to make chips snappy (optional)
        for (var cat in _categories) {
          if (cat.toLowerCase() != 'all') {
            moviesCubitFromDi.grtMoviesByGenre(10, _mapKey(cat));
          }
        }

        return moviesCubitFromDi;
      },
      child: Scaffold(
        backgroundColor: Colors.black87,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: const Text('Browse', style: TextStyle(color: Colors.white)),
        ),
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
                  if (category.toLowerCase() == 'all') {
                    cubit.getTopMovies(_pageLimit, "");
                  } else {
                    cubit.grtMoviesByGenre(_pageLimit, _mapKey(category));
                  }
                },
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: BlocBuilder<MoviesCubit, MoviesState>(
                    buildWhen: (previous, current) {
                      // نعيد البناء عند تغيّر الحالات المهمة
                      return current is MoviesLoading || current is MoviesSuccess || current is MoviesError;
                    },
                    builder: (context, state) {
                      if (state is MoviesLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (state is MoviesError) {
                        return Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Error: ${state.error}', style: const TextStyle(color: Colors.white70)),
                              const SizedBox(height: 8),
                              ElevatedButton(
                                onPressed: () {
                                  final c = _categories[_selectedChipIndex];
                                  final cubit = context.read<MoviesCubit>();
                                  if (c.toLowerCase() == 'all') {
                                    cubit.getTopMovies(_pageLimit, "");
                                  } else {
                                    cubit.grtMoviesByGenre(_pageLimit, _mapKey(c));
                                  }
                                },
                                child: const Text('Retry'),
                              ),
                            ],
                          ),
                        );
                      }

                      if (state is MoviesSuccess) {
                        final current = _categories[_selectedChipIndex];
                        final List<Movie> movies = current.toLowerCase() == 'all'
                            ? state.topMovies
                            : (state.genreMoviesMap[_mapKey(current)] ?? []);

                        if (movies.isEmpty) {
                          return const Center(
                              child: Text('No movies found', style: TextStyle(color: Colors.white70)));
                        }

                        return GridView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: movies.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                            childAspectRatio: 1 / 1.3,
                          ),
                          itemBuilder: (context, index) {
                            final Movie movie = movies[index];
                            return MovesCard(
                              posterPath: movie.image ?? '',
                              rating: movie.rating ?? 0.0,

                            );
                          },
                        );
                      }

                      // initial fallback (قبل أي state)
                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
