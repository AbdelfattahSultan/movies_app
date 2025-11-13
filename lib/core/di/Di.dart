import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'di.config.dart';

final getIt = GetIt.instance;

@injectableInit
Future<void> configureDependencies() async {
  // Register Dio manually before running generated code
  getIt.registerLazySingleton<Dio>(() => Dio());

  getIt.init();
}