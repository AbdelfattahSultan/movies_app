import 'package:flutter/material.dart';
import 'package:movies_app/core/config/app_colors.dart';
import 'package:movies_app/l10n/app_localizations.dart';

class OrLine extends StatelessWidget {
  const OrLine({super.key});

  @override
  Widget build(BuildContext context) {
    var l10n =AppLocalizations.of(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 1,
              width: double.infinity,
              color: AppColors.primary,
            ),
          ),
          Text(
            l10n!.or,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(color: AppColors.primary),
          ),
          Expanded(
            child: Container(
              height: 1,
              width: double.infinity,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
