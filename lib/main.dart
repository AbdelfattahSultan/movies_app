import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/config/app_router.dart';
import 'package:movies_app/core/di/Di.dart';
import 'package:movies_app/core/config/app_routes.dart';
import 'package:movies_app/core/theme/app_theme.dart';
import 'package:movies_app/core/utils/is_first_time.dart';
import 'package:movies_app/core/utils/token_helper.dart';
import 'package:movies_app/features/authentication/presentation/auth_cubite/lang/cubite/lan_cubit.dart';
import 'package:movies_app/features/home_screen/tabs/profile_tab/data/history/history_data_source.dart';
import 'package:movies_app/l10n/app_localizations.dart';
import 'package:movies_app/features/home_screen/tabs/profile_tab/presentation/cubit/history/history_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  final bool isFirst = await IsFirstTime.isFirstTime();

  final String? token = await TokenHelper.getToken();

  late final String startRoute;

  if (isFirst) {
    startRoute = AppRoutes.onBoarding;
  } else if (token != null && token.isNotEmpty) {
    startRoute = AppRoutes.homeScreen;
  } else {
    startRoute = AppRoutes.loginScreen;
  }
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LanCubit()),
        BlocProvider(
          create: (_) => HistoryCubit(HistoryLocalDataSource())..loadHistory(),
        ),
      ],
      child: MyApp(initialRoute: startRoute),
    ),
  );
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({super.key, required this.initialRoute});
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

      routes: AppRouter.routes,

      initialRoute: initialRoute,
    );
  }
}
