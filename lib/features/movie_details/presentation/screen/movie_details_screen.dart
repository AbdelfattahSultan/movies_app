import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/core/common_widgets/custom_button.dart';
import 'package:movies_app/core/config/app_colors.dart';
import 'package:movies_app/core/di/Di.dart';
import 'package:movies_app/features/home_screen/tabs/HomeTab/presentation/widget/moves_card.dart';
import 'package:movies_app/features/movie_details/presentation/cubit/cubit_movie_details.dart';
import 'package:movies_app/features/movie_details/presentation/cubit/cubit_movie_details_state.dart';
import 'package:movies_app/features/movie_details/presentation/cubit/fav_cubit/FavoriteCubit.dart';
import 'package:movies_app/features/movie_details/presentation/cubit/fav_cubit/FavoriteState.dart';
import 'package:movies_app/features/movie_details/widget/cast_card.dart';
import 'package:movies_app/features/movie_details/widget/genres_card.dart';
import 'package:movies_app/features/movie_details/widget/movie_badge.dart';
import 'package:movies_app/features/movie_details/widget/movie_info.dart';
import 'package:movies_app/features/movie_details/widget/screen_shoot_card.dart';

class MovieDetailsScreen extends StatelessWidget {
  const MovieDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocListener<FavoriteCubit, FavoriteState>(
          listener: (context, favState) {
            if (favState is FavoriteSuccess) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(favState.message)));
            } else if (favState is FavoriteError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(favState.error)));
            }
          },
          child: BlocBuilder<CubitMovieDetails, CubitMovieDetailsState>(
            builder: (BuildContext context, CubitMovieDetailsState state) {
              if (state is MovieDetailsLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is MovieDetailsErrorState) {
                return Center(
                  child: Text(
                    state.error,
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              } else if (state is MovieDetailsSuccessState) {
                context.read<FavoriteCubit>().checkIsFavorite(
                  state.movieDetails.id.toString(),
                );
                final movie = state.movieDetails;
                final similarMovies = state.similarMovies;
                final title = movie.title ?? '';
                final poster = movie.largeCoverImage ?? '';
                final year = movie.year?.toString() ?? '';
                final likeCount = (movie.likeCount ?? 0).toString();
                final runtime = (movie.runtime ?? 0).toString();
                final rating = (movie.rating ?? 0).toStringAsFixed(1);

                final summary =
                    (movie.descriptionIntro != null &&
                        movie.descriptionIntro!.isNotEmpty)
                    ? movie.descriptionIntro!
                    : (movie.descriptionFull ?? '');

                final genres = movie.genres ?? [];
                final castList = movie.cast ?? [];

                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      BlocBuilder<FavoriteCubit, FavoriteState>(
                        builder: (context, favState) {
                          final favCubit = context.read<FavoriteCubit>();

                          bool isFav = favCubit.isFavorite;

                          if (favState is FavoriteStatusLoaded) {
                            isFav = favState.isFavorite;
                          }

                          return MovieInfo(
                            name: title,
                            year: year,
                            poster: poster,
                            isFavorite: isFav,
                            onFavoriteTap: () {
                              favCubit.toggleFavorite(
                                movieId: movie.id.toString(),
                                name: movie.title ?? "",
                                rating: (movie.rating ?? 0).toDouble(),
                                imageURL: movie.largeCoverImage ?? "",
                                year: (movie.year ?? 0).toString(),
                              );
                            },
                          );
                        },
                      ),
                      CustomButton(
                        onTap: () {},
                        content: "Watch",
                        color: AppColors.red,
                        isRed: true,
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                MovieStatBadge(
                                  icon: Icons.favorite,
                                  value: likeCount,
                                ),
                                MovieStatBadge(
                                  icon: Icons.access_time,
                                  value: runtime,
                                ),
                                MovieStatBadge(icon: Icons.star, value: rating),
                              ],
                            ),
                            const SizedBox(height: 10),

                            Text(
                              "Screen Shoot",
                              style: GoogleFonts.roboto(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 2),
                            ScreenShootCard(
                              imagePath: movie.largeScreenshotImage1,
                            ),
                            ScreenShootCard(
                              imagePath: movie.largeScreenshotImage2,
                            ),
                            ScreenShootCard(
                              imagePath: movie.largeScreenshotImage3,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              "Similar",
                              style: GoogleFonts.roboto(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 5),
                            GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: similarMovies.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 8,
                                    mainAxisSpacing: 8,
                                    childAspectRatio: 1 / 1.3,
                                  ),
                              itemBuilder: (context, index) {
                                return MovesCard(
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
                                                      similarMovies[index].id
                                                          .toString(),
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
                                  posterPath: similarMovies[index].image ?? "",
                                  rating: similarMovies[index].rating ?? 0.0,
                                );
                              },
                            ),
                            const SizedBox(height: 16),
                            Text(
                              "Summary",
                              style: GoogleFonts.roboto(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              summary,
                              style: GoogleFonts.roboto(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              "Cast",
                              style: GoogleFonts.roboto(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 2),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: castList.length,
                              itemBuilder: (context, index) {
                                return CastCard(
                                  name: castList[index].name,
                                  character: castList[index].characterName,
                                  image: castList[index].urlSmallImage,
                                );
                              },
                            ),
                            const SizedBox(height: 16),
                            Text(
                              "Genres",
                              style: GoogleFonts.roboto(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: genres.map((genre) {
                                return GenresCard(genre: genre);
                              }).toList(),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }

              return const Center(child: Text("No data available"));
            },
          ),
        ),
      ),
    );
  }
}
