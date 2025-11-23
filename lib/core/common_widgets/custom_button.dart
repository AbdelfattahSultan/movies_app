import 'package:flutter/material.dart';
import 'package:movies_app/core/config/app_colors.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  String content;
  Color? color;
  bool? isRed;
  VoidCallback onTap;
  CustomButton({
    super.key,
    required this.onTap,
    required this.content,
    this.color,
    this.isRed = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: FilledButton(
        onPressed: onTap,
        style: FilledButton.styleFrom(
          backgroundColor: color ?? AppColors.primary,
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          content,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: isRed == true ? AppColors.white : AppColors.darkGray,
          ),
        ),
      ),
    );
  }
}
