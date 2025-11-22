import 'package:flutter/material.dart';
import 'package:movies_app/features/authentication/presentation/screen/forget_password/forget_password_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/di/Di.dart';
import 'package:movies_app/core/config/app_routes.dart';
import 'package:movies_app/core/theme/app_theme.dart';
import 'package:movies_app/features/home_screen/home_screen.dart';
import 'package:movies_app/features/home_screen/tabs/HomeTab/presentation/screens/HomeTab.dart';
import 'package:movies_app/features/authentication/presentation/screen/Login/Login.dart';
import 'package:movies_app/features/authentication/presentation/screen/Register/Register.dart';
import 'package:movies_app/features/authentication/presentation/auth_cubite/lang/cubite/lan_cubit.dart';
import 'package:movies_app/features/home_screen/tabs/profile_tab/presentation/screens/rest_password_screen.dart';
import 'package:movies_app/features/onboarding/presentation/screen/intro_screen.dart';
import 'package:movies_app/features/movie_details/presentation/screen/movie_details_screen.dart';
import 'package:movies_app/features/onboarding/presentation/screen/onBoarding.dart';
import 'package:movies_app/l10n/app_localizations.dart';
import 'features/home_screen/tabs/profile_tab/presentation/screens/profile_screen.dart';
import 'features/home_screen/tabs/profile_tab/presentation/screens/update_profile_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(
  MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => LanCubit()),
    ],
    child: const MyApp(),
  ),
);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      themeMode: ThemeMode.dark,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: context.watch<LanCubit>().state,
      routes: {
        AppRoutes.loginScreen: (context) => const Login(),
        AppRoutes.registerScreen: (context) => const Register(),
        AppRoutes.onBoarding: (context) => const Onboarding(),
        AppRoutes.introScreen: (context) => const IntroScreen(),
        AppRoutes.homeTab: (context) => const HomeTab(),
        AppRoutes.forgetPassword: (context) => const ForgetPasswordScreen(),
        AppRoutes.homeScreen: (context) => const HomeScreen(),
        AppRoutes.profileScreen: (context) => const ProfileScreen(),
        AppRoutes.resetPasswordScreen: (context) => const ResetPasswordScreen(),
        AppRoutes.updateProfileScreen: (context) => const UpdateProfileScreen(),
        AppRoutes.movieDetailScreen: (context) => const MovieDetailsScreen(),
      },
      initialRoute: AppRoutes.homeScreen,
    );
  }
}
