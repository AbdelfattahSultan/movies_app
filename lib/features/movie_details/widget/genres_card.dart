import 'package:flutter/material.dart';
import 'package:movies_app/core/config/app_colors.dart';

class GenresCard extends StatelessWidget {
  final String? genre;
  const GenresCard({super.key, required this.genre});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 122,
      padding: const EdgeInsets.symmetric(horizontal: 16),

      decoration: BoxDecoration(
        color: AppColors.darkGray,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          genre ?? "",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
