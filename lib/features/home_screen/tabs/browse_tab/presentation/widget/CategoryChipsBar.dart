import 'package:flutter/material.dart';
import 'package:movies_app/core/config/app_colors.dart';

class CategoryChipsBar extends StatelessWidget {
  static const double chipHeight = 36;
  static const double chipSpacing = 10;

  final List<String> categories;
  final int selectedIndex;
  final Function(int index, String category) onSelected;

  const CategoryChipsBar({
    super.key,
    required this.categories,
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: chipHeight + 16,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final isActive = index == selectedIndex;

          return Padding(
            padding: const EdgeInsets.only(right: chipSpacing),
            child: GestureDetector(
              onTap: () => onSelected(index, categories[index]),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                curve: Curves.easeOut,
                height: chipHeight,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: isActive ? AppColors.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: isActive
                        ? AppColors.primary
                        : AppColors.primary.withOpacity(0.6),
                  ),
                  boxShadow: isActive
                      ? [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.18),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    )
                  ]
                      : null,
                ),
                alignment: Alignment.center,
                child: Text(
                  categories[index],
                  style: TextStyle(
                    color: isActive ? Colors.black : AppColors.primary,
                    fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
