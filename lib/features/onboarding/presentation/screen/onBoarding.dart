import 'package:flutter/material.dart';
import 'package:movies_app/core/common_widgets/custom_button.dart';
import 'package:movies_app/core/config/app_images.dart';
import 'package:movies_app/core/config/app_routes.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.moviesPosters),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 33),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Find Your Next\nFavorite Movie Here",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Get access to a huge library of movies\nto suit all tastes. You will surely like it.",
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                CustomButton(onTap: () {
                  Navigator.pushNamed(context, AppRoutes.introScreen);
                }, content: "Explore Now"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
