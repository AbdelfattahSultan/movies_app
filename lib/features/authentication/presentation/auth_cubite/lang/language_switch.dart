import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:movies_app/core/config/app_colors.dart';
import 'package:movies_app/features/authentication/presentation/auth_cubite/lang/cubite/lan_cubit.dart';

// ignore: camel_case_types

class LanguageSwitch extends StatefulWidget {
  const LanguageSwitch({super.key});

  @override
  State<LanguageSwitch> createState() => _LanguageSwitchState();
}

class _LanguageSwitchState extends State<LanguageSwitch> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanCubit, Locale>(
      builder: (context, state) {
        bool isEnglish = state.languageCode == "en";
        return AnimatedToggleSwitch<bool>.rolling(
          current: isEnglish,
          values: [true, false],
          onChanged: (value) {
            context.read<LanCubit>().toggleLanguage();
          },
          iconBuilder: (value, foreground) {
            return value ? Flag(Flags.united_kingdom) : Flag(Flags.egypt);
          },
          style: ToggleStyle(
            indicatorColor: Theme.of(context).colorScheme.primary,
            borderColor: AppColors.primary,
            backgroundColor: AppColors.primary.withOpacity(0.1),
          ),
        );
      },
    );
  }
}
