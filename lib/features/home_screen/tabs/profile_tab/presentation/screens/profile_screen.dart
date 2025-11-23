import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:movies_app/core/config/app_colors.dart';
import 'package:movies_app/core/config/app_images.dart';
import 'package:movies_app/core/config/app_routes.dart';

import 'package:movies_app/core/di/Di.dart';
import 'package:movies_app/core/utils/token_helper.dart';

import 'package:movies_app/features/home_screen/tabs/HomeTab/domain/model/movie.dart';
import 'package:movies_app/features/home_screen/tabs/HomeTab/presentation/widget/moves_card.dart';

import 'package:movies_app/features/home_screen/tabs/profile_tab/data/models/user_model.dart';
import 'package:movies_app/features/home_screen/tabs/profile_tab/data/repositories/profile_repo/profile_repository.dart';
import 'package:movies_app/features/home_screen/tabs/profile_tab/presentation/cubit/profile_cubit/profile_cubit.dart';
import 'package:movies_app/features/home_screen/tabs/profile_tab/presentation/cubit/profile_cubit/profile_state.dart';

import 'package:movies_app/features/home_screen/tabs/profile_tab/presentation/cubit/history/history_cubit.dart';
import 'package:movies_app/features/home_screen/tabs/profile_tab/presentation/cubit/history/history_state.dart';
import 'package:movies_app/features/home_screen/tabs/profile_tab/presentation/screens/update_profile_screen.dart';

import 'package:movies_app/features/movie_details/presentation/cubit/cubit_movie_details.dart';
import 'package:movies_app/features/movie_details/presentation/cubit/fav_cubit/FavoriteCubit.dart';
import 'package:movies_app/features/movie_details/presentation/screen/movie_details_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int selectedIndex = 0;

  final List<String> avatars = [
    AppImages.avatar1,
    AppImages.avatar2,
    AppImages.avatar3,
    AppImages.avatar4,
    AppImages.avatar5,
    AppImages.avatar6,
    AppImages.avatar7,
    AppImages.avatar8,
    AppImages.avatar9,
  ];

  String getAvatarImage(int? avatarId) {
    if (avatarId != null && avatarId >= 1 && avatarId <= avatars.length) {
      return avatars[avatarId - 1];
    } else {
      return avatars[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    final dio = Dio();
    final favoritesRepo = FavoritesRepositoryImpl(FavoritesDataSourceImpl(dio));
    final historyLocal = HistoryLocalDataSource();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ProfileCubit(ProfileRepository())..getProfile()),
        BlocProvider(create: (_) => FavoritesCubit(favoritesRepo)..loadFavorites()),
        BlocProvider(create: (_) => HistoryCubit(historyLocal)..loadHistory()),
      ],
      child: Scaffold(
        backgroundColor: AppColors.eerieBlack,
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(child: CircularProgressIndicator(color: Colors.yellow));
            }

            if (state is ProfileError) {
              return Center(
                child: Text("Error: ${state.message}", style: const TextStyle(color: Colors.red)),
              );
            } else if (state is ProfileLoaded) {
              UserModel user = state.user;
              List<Movie> favorites = state.favorites;

              List<Movie> historyList = [];
              final historyState = context.watch<HistoryCubit>().state;
              if (historyState is HistoryLoaded) {
                historyList = historyState.movies;
              }

              final int watchListCount = favorites.length;
              final int historyCount = historyList.length;

              return Column(
                children: [
                  Container(
                    color: AppColors.darkGray,
                    padding: const EdgeInsets.only(top: 52, left: 16, right: 16, bottom: 12),
                    child: Column(
                      children: [

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // Avatar + Name
                            Expanded(
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(60),
                                    child: Image.asset(
                                      getAvatar(user.avaterId),
                                      width: 95,
                                      height: 95,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    user.name,
                                    style: GoogleFonts.roboto(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Watch List count
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    watchListCount.toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Text(
                                    "Watch List",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // History count
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    historyCount.toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Text(
                                    "History",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 25),

                        // Edit + Logout
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: InkWell(
                                onTap: () async {
                                  final updated = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => BlocProvider.value(
                                        value: context.read<ProfileCubit>(),
                                        child: const UpdateProfileScreen(),
                                      ),
                                      settings: RouteSettings(arguments: user),
                                    ),
                                  );

                                  if (updated is UserModel) {
                                    context.read<ProfileCubit>().updateProfile(updated);
                                  }
                                },
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: const Center(
                                    child: Text("Edit Profile",
                                        style: TextStyle(color: Colors.black, fontSize: 18)),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              flex: 1,
                              child: InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      backgroundColor: AppColors.darkGray,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      title: Text(
                                        "Log Out",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      content: const Text(
                                        "Are you sure you want to log out?",
                                        style: TextStyle(color: Colors.white70),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Text(
                                            "Cancel",
                                            style: TextStyle(
                                              color: Colors.white70,
                                            ),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            Navigator.pop(context);
                                            await TokenHelper.deleteToken();
                                            Navigator.pushNamedAndRemoveUntil(
                                              context,
                                              AppRoutes.loginScreen,
                                              (route) => false,
                                            );
                                          },
                                          child: Text(
                                            "Log Out",
                                            style: TextStyle(
                                              color: AppColors.primary,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: AppColors.red,
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: const Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("Exit",
                                            style:
                                            TextStyle(color: Colors.white, fontSize: 18)),
                                        SizedBox(width: 6),
                                        Icon(Icons.exit_to_app,
                                            color: Colors.white, size: 22),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 25),

                        // Tabs: Watch List / History
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () => setState(() => selectedIndex = 0),
                              child: Column(
                                children: [
                                  Icon(Icons.list,
                                      color: AppColors.primary, size: 40),
                                  Text("Watch List",
                                      style: GoogleFonts.roboto(
                                          color: Colors.white, fontSize: 20)),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () => setState(() => selectedIndex = 1),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.history,
                                    color: AppColors.primary,
                                    size: 40,
                                  ),
                                  Text(
                                    "History",
                                    style: GoogleFonts.roboto(
                                      color: AppColors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 5),

                        AnimatedAlign(
                          duration: const Duration(milliseconds: 300),
                          alignment:
                          selectedIndex == 0 ? Alignment.centerLeft : Alignment.centerRight,
                          child: Container(
                            height: 1.5,
                            width: MediaQuery.of(context).size.width / 2,
                            color: AppColors.primary,
                          ),
                        ),

                      ],
                    ),
                  ),

                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Container(
                        color: AppColors.eerieBlack,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 20,
                        ),
                        child: Builder(
                          builder: (context) {
                            final List<Movie> watchList = favorites;
                            final List<Movie> historyMovies = historyList;

                            final currentList = selectedProfileTabIndex == 0
                                ? watchList
                                : historyMovies;

                            if (currentList.isEmpty) {
                              return Center(
                                child: Text(
                                  selectedProfileTabIndex == 0
                                      ? "No movies in Watch List yet."
                                      : "No movies in History yet.",
                                  style: const TextStyle(color: Colors.white70),
                                ),
                              );
                            }

                            return GridView.builder(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemCount: currentList.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 11,
                                    mainAxisSpacing: 11,
                                    childAspectRatio: 1 / 1.3,
                                  ),
                              itemBuilder: (context, index) {
                                final Movie movie = currentList[index];

                                return MovesCard(
                                  posterPath: movie.image ?? '',
                                  rating: movie.rating ?? 0.0,
                                  onTap: () {
                                
                                    context.read<HistoryCubit>().addMovie(
                                      movie,
                                    );

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
                              childCount: list.length,
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
