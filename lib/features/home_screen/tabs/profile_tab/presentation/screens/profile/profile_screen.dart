import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/core/config/app_colors.dart';
import 'package:movies_app/core/config/app_images.dart';
import 'package:movies_app/core/config/app_routes.dart';
import 'package:movies_app/features/profile/data/models/user_model.dart';
import 'package:movies_app/features/profile/data/repositories/profile_repository.dart';
import 'package:movies_app/features/profile/logic/cubit/profile_cubit.dart';
import 'package:movies_app/features/profile/logic/cubit/profile_state.dart';
import 'update_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int selectedProfileTabIndex = 0;
  int selectedBottomIndex = 3;

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

  String getAvatarImage(int avatarId) {
    if (avatarId >= 1 && avatarId <= avatars.length) {
      return avatars[avatarId - 1];
    } else {
      return avatars[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(ProfileRepository())..getProfile(),
      child: Scaffold(
        backgroundColor: AppColors.eerieBlack,
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.yellow),
              );
            } else if (state is ProfileError) {
              return Center(
                child: Text(
                  "Error: ${state.message}",
                  style: const TextStyle(color: Colors.red),
                ),
              );
            } else if (state is ProfileLoaded) {
              UserModel user = state.user;
              return Column(
                children: [
                  Container(
                    color: AppColors.darkGray,
                    padding: const EdgeInsets.only(
                      top: 52,
                      left: 16,
                      right: 16,
                    ),
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
                                      getAvatarImage(user.avaterId),
                                      width: 95,
                                      height: 95,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    user.name,
                                    style: GoogleFonts.roboto(
                                      color: AppColors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: const [
                                  Text(
                                    "12",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "Wish List",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: const [
                                  Text(
                                    "10",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
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
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: InkWell(
                                onTap: () async {
                                  final updatedUser = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => BlocProvider.value(
                                        value: context.read<ProfileCubit>(),
                                        child: const UpdateProfileScreen(),
                                      ),
                                      settings: RouteSettings(arguments: user),
                                    ),
                                  );

                                  if (updatedUser is UserModel) {
                                    setState(() {
                                      user = updatedUser;
                                    });
                                  }
                                },
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "Edit Profile",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
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
                                      title: const Text(
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
                                          onPressed: () {
                                            Navigator.pop(context);
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Exit",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(width: 6),
                                        Icon(
                                          Icons.exit_to_app,
                                          color: Colors.white,
                                          size: 22,
                                        ),
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
                              onTap: () =>
                                  setState(() => selectedProfileTabIndex = 0),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.list,
                                    color: AppColors.primary,
                                    size: 40,
                                  ),
                                  Text(
                                    "Watch List",
                                    style: GoogleFonts.roboto(
                                      color: AppColors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () =>
                                  setState(() => selectedProfileTabIndex = 1),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.folder,
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
                        const SizedBox(height: 12),
                        AnimatedAlign(
                          duration: const Duration(milliseconds: 300),
                          alignment: selectedProfileTabIndex == 0
                              ? Alignment.centerLeft
                              : Alignment.centerRight,
                          child: Container(
                            height: 2,
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
                            final List<String> watchList = [];
                            final List<String> historyList = [];
                            final currentList = selectedProfileTabIndex == 0
                                ? watchList
                                : historyList;

                            return GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 8,
                                    mainAxisSpacing: 12,
                                    childAspectRatio: 0.65,
                                  ),
                              itemCount: currentList.length,
                              itemBuilder: (context, index) {
                                return const SizedBox.shrink();
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
        bottomNavigationBar: SafeArea(
          minimum: const EdgeInsets.only(bottom: 8, left: 12, right: 12),
          child: Container(
            height: 63,
            decoration: BoxDecoration(
              color: AppColors.darkGray,
              borderRadius: BorderRadius.circular(25),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor: AppColors.darkGray,
                selectedItemColor: AppColors.primary,
                unselectedItemColor: Colors.white,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                currentIndex: selectedBottomIndex,
                onTap: (index) {
                  setState(() {
                    selectedBottomIndex = index;
                  });
                  switch (index) {
                    case 0:
                      Navigator.pushNamed(context, AppRoutes.homeScreen);
                      break;
                    case 3:
                      Navigator.pushNamed(context, AppRoutes.profileScreen);
                      break;
                  }
                },
                items: [
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      AppImages.homeIcon,
                      colorFilter: ColorFilter.mode(
                        selectedBottomIndex == 0
                            ? AppColors.primary
                            : Colors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      AppImages.searchIcon,
                      colorFilter: ColorFilter.mode(
                        selectedBottomIndex == 1
                            ? AppColors.primary
                            : Colors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                    label: 'Search',
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      AppImages.exploreIcon,
                      colorFilter: ColorFilter.mode(
                        selectedBottomIndex == 2
                            ? AppColors.primary
                            : Colors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                    label: 'Explore',
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      AppImages.profileIcon,
                      colorFilter: ColorFilter.mode(
                        selectedBottomIndex == 3
                            ? AppColors.primary
                            : Colors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                    label: 'Profile',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
