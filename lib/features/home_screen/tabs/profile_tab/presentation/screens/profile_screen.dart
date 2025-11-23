import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/core/config/app_colors.dart';
import 'package:movies_app/core/config/app_images.dart';
import 'package:movies_app/core/config/app_routes.dart';
import 'package:movies_app/core/utils/token_helper.dart';
import 'package:dio/dio.dart';
import 'package:movies_app/features/home_screen/tabs/HomeTab/domain/model/movie.dart';
import 'package:movies_app/features/home_screen/tabs/profile_tab/data/models/user_model.dart';
import 'package:movies_app/features/home_screen/tabs/profile_tab/data/repositories/profile_repo/profile_repository.dart';
import 'package:movies_app/features/home_screen/tabs/profile_tab/presentation/cubit/profile_cubit/profile_cubit.dart';
import 'package:movies_app/features/home_screen/tabs/profile_tab/presentation/cubit/profile_cubit/profile_state.dart';
import '../../../../../../core/di/Di.dart';
import '../../../../../movie_details/presentation/cubit/cubit_movie_details.dart';
import '../../../../../movie_details/presentation/screen/movie_details_screen.dart';
import '../../favourites/data/data_source/favorites_data_source_impl.dart';
import '../../favourites/data/repositories/favorites_repository_impl.dart';
import '../../favourites/presentation/cubit/favorites_cubit.dart';
import '../../history/data/history_local_data_source.dart';
import '../../history/presentation/cubit/history_cubit.dart';
import '../../history/presentation/cubit/history_state.dart';
import '../../favourites/presentation/cubit/favorites_state.dart';
import 'update_profile_screen.dart';

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

  String getAvatar(int id) {
    if (id >= 1 && id <= avatars.length) return avatars[id - 1];
    return avatars[0];
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
            }

            if (state is! ProfileLoaded && state is! ProfileUpdated) {
              return const SizedBox.shrink();
            }

            final user = state is ProfileLoaded ? state.user : (state as ProfileUpdated).user;

            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    color: AppColors.darkGray,
                    padding: const EdgeInsets.only(top: 52, left: 16, right: 16, bottom: 12),
                    child: Column(
                      children: [

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
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

                            Expanded(
                              child: BlocBuilder<FavoritesCubit, FavoritesState>(
                                builder: (context, fav) {
                                  final count = fav is FavoritesLoaded ? fav.movies.length : 0;
                                  return Column(
                                    children: [
                                      Text("$count",
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold)),
                                      const Text("Wish List",
                                          style: TextStyle(color: Colors.white, fontSize: 16)),
                                    ],
                                  );
                                },
                              ),
                            ),

                            Expanded(
                              child: BlocBuilder<HistoryCubit, HistoryState>(
                                builder: (context, hist) {
                                  final count = hist is HistoryLoaded ? hist.movies.length : 0;
                                  return Column(
                                    children: [
                                      Text("$count",
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold)),
                                      const Text("History",
                                          style: TextStyle(color: Colors.white, fontSize: 16)),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 25),

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
                                onTap: () async {
                                  await TokenHelper.deleteToken();
                                  Navigator.pushNamedAndRemoveUntil(
                                      context, AppRoutes.loginScreen, (_) => false);
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
                                  Icon(Icons.folder,
                                      color: AppColors.primary, size: 40),
                                  Text("History",
                                      style: GoogleFonts.roboto(
                                          color: Colors.white, fontSize: 20)),
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
                ),

                SliverPadding(
                  padding: const EdgeInsets.all(12),
                  sliver: BlocBuilder<FavoritesCubit, FavoritesState>(
                    builder: (_, fav) {
                      return BlocBuilder<HistoryCubit, HistoryState>(
                        builder: (_, hist) {
                          final watch =
                          fav is FavoritesLoaded ? fav.movies : <Movie>[];
                          final history =
                          hist is HistoryLoaded ? hist.movies : <Movie>[];

                          final list = selectedIndex == 0 ? watch : history;

                          if (list.isEmpty) {
                            return const SliverToBoxAdapter(
                              child: SizedBox(
                                height: 350,
                                child: Center(
                                  child: Text("No items yet",
                                      style: TextStyle(color: Colors.white70)),
                                ),
                              ),
                            );
                          }

                          return SliverGrid(
                            gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 14,
                              crossAxisSpacing: 14,
                              childAspectRatio: 0.62,
                            ),
                            delegate: SliverChildBuilderDelegate(
                                  (context, index) {
                                final movie = list[index];

                                return GestureDetector(
                                  onTap: () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => MultiBlocProvider(
                                          providers: [
                                            BlocProvider(
                                              create: (_) =>
                                              CubitMovieDetails(getIt())
                                                ..loadMovie(movie.id.toString()),
                                            ),
                                            BlocProvider.value(
                                                value: context.read<FavoritesCubit>()),
                                            BlocProvider.value(
                                                value: context.read<HistoryCubit>()),
                                          ],
                                          child: const MovieDetailsScreen(),
                                        ),
                                      ),
                                    );

                                    await context.read<FavoritesCubit>().loadFavorites();
                                    await context.read<HistoryCubit>().loadHistory();
                                  },
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(12),
                                          child: Image.network(
                                            movie.image ?? "",
                                            fit: BoxFit.cover,
                                            errorBuilder: (_, __, ___) =>
                                                Container(color: Colors.grey),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        movie.title ?? "",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(color: Colors.white),
                                      ),
                                      Text(
                                        movie.rating.toString(),
                                        style:
                                        const TextStyle(color: Colors.white70),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              childCount: list.length,
                            ),
                          );
                        },
                      );
                    },
                  ),
                )

              ],
            );
          },
        ),
      ),
    );
  }
}
