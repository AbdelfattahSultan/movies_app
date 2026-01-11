import 'package:flutter/material.dart';

import 'package:movies_app/core/config/app_routes.dart';

import 'package:movies_app/features/authentication/presentation/screen/Login/Login.dart';
import 'package:movies_app/features/authentication/presentation/screen/Register/Register.dart';
import 'package:movies_app/features/authentication/presentation/screen/forget_password/forget_password_screen.dart';

import 'package:movies_app/features/onboarding/presentation/screen/onBoarding.dart';
import 'package:movies_app/features/onboarding/presentation/screen/intro_screen.dart';

import 'package:movies_app/features/home_screen/home_screen.dart';
import 'package:movies_app/features/home_screen/tabs/HomeTab/presentation/screens/HomeTab.dart';
import 'package:movies_app/features/home_screen/tabs/browse_tab/presentation/screens/Browse_tab.dart';

import 'package:movies_app/features/home_screen/tabs/profile_tab/presentation/screens/profile_screen.dart';
import 'package:movies_app/features/home_screen/tabs/profile_tab/presentation/screens/rest_password_screen.dart';
import 'package:movies_app/features/home_screen/tabs/profile_tab/presentation/screens/update_profile_screen.dart';

import 'package:movies_app/features/movie_details/presentation/screen/movie_details_screen.dart';


class AppRouter {
  static Map<String, Widget Function(BuildContext)> get routes {
    return {
      AppRoutes.loginScreen: (context) => const Login(),
      AppRoutes.registerScreen: (context) => const Register(),
      AppRoutes.onBoarding: (context) => const Onboarding(),
      AppRoutes.introScreen: (context) => const IntroScreen(),
      AppRoutes.homeTab: (context) => HomeTab(
        onSeeMoreTap: (_) {},
      ),
      AppRoutes.forgetPassword: (context) => const ForgetPasswordScreen(),
      AppRoutes.homeScreen: (context) => const HomeScreen(),
      AppRoutes.profileScreen: (context) => const ProfileScreen(),
      AppRoutes.resetPasswordScreen: (context) => const ResetPasswordScreen(),
      AppRoutes.updateProfileScreen: (context) => const UpdateProfileScreen(),
      AppRoutes.movieDetailScreen: (context) => const MovieDetailsScreen(),
      AppRoutes.browseTab: (context) => BrowseTab(),
    };
  }
}
