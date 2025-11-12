import 'package:flutter/material.dart';

import 'package:movies_app/presentation/screens/profile/profile_screen.dart';

import 'core/config/app_routes.dart';
import 'presentation/screens/update_profile_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.profileScreen,
      routes: {
        AppRoutes.profileScreen: (context) => const ProfileScreen(),
        AppRoutes.updateProfileScreen: (context) => const UpdateProfileScreen(),
      },
    );
  }
}
