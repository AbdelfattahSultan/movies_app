import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/config/app_routes.dart';
import 'package:movies_app/core/theme/app_theme.dart';
import 'package:movies_app/features/authentication/presentation/screen/Login/Login.dart';
import 'package:movies_app/features/authentication/presentation/screen/Register/Register.dart';
import 'package:movies_app/features/authentication/presentation/auth_cubite/lang/cubite/lan_cubit.dart';
import 'package:movies_app/l10n/app_localizations.dart';

void main() {
  runApp(BlocProvider(create: (context) => LanCubit(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.theme,
      themeMode: ThemeMode.dark,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: context.watch<LanCubit>().state,
      routes: {
        AppRoutes.loginScreen: (context) => const Login(),
        AppRoutes.registerScreen: (context) => const Register(),
      },
      initialRoute: AppRoutes.loginScreen,
    );
  }
}
