import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/core/config/app_colors.dart';
import 'package:movies_app/core/config/app_images.dart';
import 'package:movies_app/features/home_screen/tabs/HomeTab/presentation/screens/HomeTab.dart';
import 'package:movies_app/features/home_screen/tabs/browse_tab/presentation/screens/browse_tap.dart';
import 'package:movies_app/features/home_screen/tabs/search_tab/presentation/screens/search_tap.dart';
import 'package:movies_app/features/home_screen/tabs/profile_tab/presentation/screens/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int navIndex = 0;

  final List<Widget> pages = const [
    HomeTab(),
    SearchTap(),
    BrowseTap(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: pages[navIndex],
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
          clipBehavior: Clip.antiAlias,
          child: BottomNavigationBar(
            currentIndex: navIndex,
            onTap: (index) {
            
                setState(() {
                  navIndex = index;
                });
              
            },
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppImages.homeIcon,
                  colorFilter: ColorFilter.mode(
                    navIndex == 0 ? AppColors.primary : Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppImages.searchIcon,
                  colorFilter: ColorFilter.mode(
                    navIndex == 1 ? AppColors.primary : Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppImages.exploreIcon,
                  colorFilter: ColorFilter.mode(
                    navIndex == 2 ? AppColors.primary : Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
                label: 'Browse',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppImages.profileIcon,
                  colorFilter: ColorFilter.mode(
                    navIndex == 3 ? AppColors.primary : Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
