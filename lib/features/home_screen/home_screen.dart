import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies_app/core/config/app_images.dart';
import 'package:movies_app/features/home_screen/tabs/HomeTab/presentation/screens/HomeTab.dart';
import 'package:movies_app/features/home_screen/tabs/browse_tab/presentation/screens/browse_tap.dart';
import 'package:movies_app/features/home_screen/tabs/profile_tab/presentation/screens/Profile_tap.dart';
import 'package:movies_app/features/home_screen/tabs/search_tab/presentation/screens/search_tap.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int navIndex = 0;

  List<Widget> pages = const [
    HomeTab(),
    SearchTap(),
    BrowseTap(),
    ProfileTap(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[navIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(),
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 9),
        child: BottomNavigationBar(
          currentIndex: navIndex,
          showSelectedLabels: true,
          elevation: 0,
          onTap: (index) {
            setState(() {
              navIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(AppImages.homeIcn),
              label: '',
              activeIcon: SvgPicture.asset(AppImages.homeFill),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(AppImages.searchIcn),
              label: '',
              activeIcon: SvgPicture.asset(AppImages.searchFill),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(AppImages.browseIcn),
              label: '',
              activeIcon: SvgPicture.asset(AppImages.browseFill),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(AppImages.profileIcn),
              label: '',
              activeIcon: SvgPicture.asset(AppImages.profileFill),
            ),
          ],
        ),
      ),
    );
  }
}
