import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/config/app_colors.dart';
import 'package:movies_app/core/config/app_images.dart';
import 'package:movies_app/core/di/Di.dart';
import 'package:movies_app/features/home_screen/tabs/HomeTab/presentation/cubit/movies_cubit.dart';
import 'package:movies_app/features/home_screen/tabs/HomeTab/presentation/cubit/movies_state.dart';
import 'package:movies_app/features/home_screen/tabs/HomeTab/presentation/widget/CategorySection.dart';
import 'package:movies_app/features/home_screen/tabs/HomeTab/domain/model/movie.dart';
import 'package:movies_app/features/home_screen/tabs/HomeTab/presentation/widget/carousel_card.dart';
import 'package:movies_app/features/movie_details/presentation/cubit/cubit_movie_details.dart';
import 'package:movies_app/features/movie_details/presentation/cubit/fav_cubit/FavoriteCubit.dart';
import 'package:movies_app/features/movie_details/presentation/screen/movie_details_screen.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  String? _currentMovieImage;
  final List<String> genresToDisplay = const [
    "Action",
    "Comedy",
    "Thriller",
    "Romance",
  ];

  Widget _buildGenreSection(BuildContext context, String genre) {
    return BlocBuilder<MoviesCubit, MoviesState>(
      buildWhen: (previous, current) => current is MoviesSuccess,
      builder: (context, state) {
        if (state is MoviesSuccess) {
          final moviesList = state.genreMoviesMap[genre.toLowerCase()];
          if (moviesList != null && moviesList.isNotEmpty) {
            return CategorySection(title: "$genre ", movies: moviesList);
          }
        }
        return const SizedBox();
      },
    );
  }

  void _updateBackgroundImage(List<Movie> movies, int index) {
    if (movies.isNotEmpty && index >= 0 && index < movies.length) {
      setState(() {
        _currentMovieImage = movies[index].image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final moviesCubit = getIt.get<MoviesCubit>();
    final size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (context) {
        moviesCubit.getTopMovies();
        for (var genre in genresToDisplay) {
          moviesCubit.grtMoviesByGenre(10, genre.toLowerCase());
        }
        return moviesCubit;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<MoviesCubit, MoviesState>(
                buildWhen: (previous, current) => current is MoviesSuccess,
                builder: (context, state) {
                  if (state is MoviesSuccess &&
                      state.topMovies.isNotEmpty &&
                      _currentMovieImage == null) {
                    _currentMovieImage = state.topMovies.first.image;
                  }

                  final displayImage = _currentMovieImage;

                  return Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.75,
                        decoration: BoxDecoration(
                          image: displayImage != null && displayImage.isNotEmpty
                              ? DecorationImage(
                                  image: NetworkImage(displayImage),
                                  fit: BoxFit.cover,
                                  colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(0.4),
                                    BlendMode.darken,
                                  ),
                                )
                              : null,
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              AppColors.darkGray.withOpacity(0.7),
                              AppColors.darkGray,
                            ],
                            stops: const [0.4, 0.85, 1.0],
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Image(
                                image: AssetImage(AppImages.availableNow),
                              ),
                              BlocBuilder<MoviesCubit, MoviesState>(
                                builder: (context, state) {
                                  if (state is MoviesLoading) {
                                    return const Padding(
                                      padding: EdgeInsets.all(20),
                                      child: CircularProgressIndicator(),
                                    );
                                  }

                                  if (state is MoviesSuccess) {
                                    final topMovies = state.topMovies;
                                    return CarouselSlider(
                                      options: CarouselOptions(
                                        height: size.height * 0.45,
                                        enlargeCenterPage: true,
                                        viewportFraction: 0.6,
                                        aspectRatio: 16 / 9,
                                        onPageChanged: (index, reason) {
                                          _updateBackgroundImage(
                                            topMovies,
                                            index,
                                          );
                                        },
                                      ),
                                      items: topMovies.map((movie) {
                                        return CarouselCard(
                                          image: movie.image ?? "",
                                          rating: movie.rating ?? 0.0,
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) => MultiBlocProvider(
                                                  providers: [
                                                    BlocProvider(
                                                      create: (_) =>
                                                          getIt<
                                                              CubitMovieDetails
                                                            >()
                                                            ..loadMovie(
                                                              movie.id
                                                                  .toString(),
                                                            ),
                                                    ),
                                                    BlocProvider(
                                                      create: (_) =>
                                                          getIt<
                                                            FavoriteCubit
                                                          >(),
                                                    ),
                                                  ],
                                                  child:
                                                      const MovieDetailsScreen(),
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      }).toList(),
                                    );
                                  }

                                  if (state is MoviesError) {
                                    return Text(
                                      "Error: ${state.error}",
                                      style: const TextStyle(color: Colors.red),
                                    );
                                  }
                                  return const SizedBox();
                                },
                              ),
                              const Image(
                                image: AssetImage(AppImages.watchNow),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              ...genresToDisplay.map(
                (genre) => _buildGenreSection(context, genre),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
