import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/config/app_colors.dart';
import 'package:movies_app/core/config/app_images.dart';
import 'package:movies_app/features/home_screen/tabs/HomeTab/domain/model/movie.dart';
import 'package:movies_app/features/home_screen/tabs/HomeTab/presentation/cubit/movies_cubit.dart';
import 'package:movies_app/features/home_screen/tabs/HomeTab/presentation/cubit/movies_state.dart';
import 'package:movies_app/features/home_screen/tabs/HomeTab/presentation/widget/CategorySection.dart';
import 'package:movies_app/features/home_screen/tabs/HomeTab/presentation/widget/carousel_card.dart';
import 'package:movies_app/features/home_screen/tabs/profile_tab/presentation/cubit/history/history_cubit.dart';
import 'package:movies_app/features/movie_details/presentation/cubit/cubit_movie_details.dart';
import 'package:movies_app/features/movie_details/presentation/cubit/fav_cubit/FavoriteCubit.dart';
import 'package:movies_app/features/movie_details/presentation/screen/movie_details_screen.dart';
import 'package:movies_app/core/di/Di.dart';

class HomeTab extends StatefulWidget {
  final void Function(int index) onSeeMoreTap;

  const HomeTab({super.key, required this.onSeeMoreTap});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  String? currentImage;

  final genres = ["Action", "Adventure", "Comedy", "Crime"];

  void updateBackground(List<Movie> movies, int index) {
    if (index < movies.length) {
      setState(() {
        currentImage = movies[index].image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MoviesCubit>();
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<MoviesCubit, MoviesState>(
              builder: (_, state) {
                if (state is MoviesLoading) {
                  return const SizedBox(
                    height: 300,
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                if (state is MoviesSuccess) {
                  final topMovies = state.topMovies;

                  if (currentImage == null && topMovies.isNotEmpty) {
                    currentImage = topMovies.first.image;
                  }

                  return Stack(
                    children: [
                      Container(
                        height: size.height * 0.75,
                        decoration: BoxDecoration(
                          image: currentImage != null
                              ? DecorationImage(
                            image: NetworkImage(currentImage!),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.4),
                              BlendMode.darken,
                            ),
                          )
                              : null,
                        ),
                      ),

                      Positioned.fill(
                        child: Column(
                          children: [
                            const SizedBox(height: 30),
                            const Image(image: AssetImage(AppImages.availableNow)),

                            CarouselSlider(
                              options: CarouselOptions(
                                height: size.height * 0.45,
                                enlargeCenterPage: true,
                                viewportFraction: 0.6,
                                onPageChanged: (i, _) =>
                                    updateBackground(topMovies, i),
                              ),
                              items: topMovies.map((movie) {
                                return CarouselCard(
                                  image: movie.image ?? "",
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
                              }).toList(),
                            ),

                            const Image(image: AssetImage(AppImages.watchNow)),
                          ],
                        ),
                      ),
                    ],
                  );
                }

                return const SizedBox();
              },
            ),

            ...genres.map(
                  (g) => BlocBuilder<MoviesCubit, MoviesState>(
                builder: (_, s) {
                  if (s is MoviesSuccess) {
                    final movies =
                        s.genreMoviesMap[g.toLowerCase()] ?? [];

                    if (movies.isEmpty) return const SizedBox();

                    return CategorySection(
                      title: g,
                      movies: movies,
                      onSeeMore: () {
                        final index = genres.indexOf(g);
                        widget.onSeeMoreTap(index);
                      },
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
