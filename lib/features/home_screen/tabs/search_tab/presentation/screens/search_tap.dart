import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/core/config/app_colors.dart';
import 'package:movies_app/core/config/app_images.dart';
import 'package:movies_app/core/di/Di.dart';
import 'package:movies_app/features/home_screen/tabs/HomeTab/presentation/widget/moves_card.dart';
import 'package:movies_app/features/home_screen/tabs/profile_tab/presentation/cubit/history/history_cubit.dart';
import 'package:movies_app/features/home_screen/tabs/search_tab/domain/repo/search_repo.dart';
import 'package:movies_app/features/home_screen/tabs/search_tab/presentation/cubit/search_cubit.dart';
import 'package:movies_app/features/home_screen/tabs/search_tab/presentation/cubit/search_state.dart';
import 'package:movies_app/features/movie_details/presentation/cubit/cubit_movie_details.dart';
import 'package:movies_app/features/movie_details/presentation/cubit/fav_cubit/FavoriteCubit.dart';
import 'package:movies_app/features/movie_details/presentation/screen/movie_details_screen.dart';

class SearchTap extends StatelessWidget {
  const SearchTap({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(getIt<SearchRepo>()),
      child: const SearchViewContent(),
    );
  }
}

class SearchViewContent extends StatelessWidget {
  const SearchViewContent({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SearchCubit>();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: cubit.controller,
                onSubmitted: (_) => cubit.searchMovies(),
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
                decoration: InputDecoration(
                  hintText: "Search",
                  hintStyle: GoogleFonts.roboto(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: AppColors.white,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      cubit.clear();
                    },
                    icon: const Icon(Icons.close, color: AppColors.white),
                  ),
                  prefixIcon: IconButton(
                    onPressed: () {
                      cubit.searchMovies();
                    },
                    icon: SvgPicture.asset(AppImages.searchIcon),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: BlocBuilder<SearchCubit, SearchState>(
                  builder: (context, state) {
                    if (state is LoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is ErrorState) {
                      return Center(child: Text(state.message));
                    } else if (state is EmptyState) {
                      return Center(child: Text(state.message));
                    } else if (state is SuccessState) {
                      final movies = state.movies;

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
                          final movie = movies[index];
                          return MovesCard(
                            posterPath: movie.image ?? '',
                            rating: movie.rating ?? 0.0,
                            onTap: () {
                              context.read<HistoryCubit>().addMovie(movie);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => MultiBlocProvider(
                                    providers: [
                                      BlocProvider(
                                        create: (_) =>
                                            getIt<CubitMovieDetails>()
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
                    return Center(
                      child: Image.asset(
                        AppImages.empty,
                        width: 124,
                        height: 124,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
