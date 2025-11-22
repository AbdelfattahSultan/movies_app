// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:movies_app/core/di/DioModule.dart' as _i660;
import 'package:movies_app/features/home_screen/tabs/HomeTab/api/Api_manger.dart'
    as _i749;
import 'package:movies_app/features/home_screen/tabs/HomeTab/data/data_source/movies_data_source.dart'
    as _i325;
import 'package:movies_app/features/home_screen/tabs/HomeTab/data/data_source/movies_data_source_impl.dart'
    as _i916;
import 'package:movies_app/features/home_screen/tabs/HomeTab/data/reposatry/movies_reposatry_impl.dart'
    as _i807;
import 'package:movies_app/features/home_screen/tabs/HomeTab/domain/repositories/movies_reposatry.dart'
    as _i509;
import 'package:movies_app/features/home_screen/tabs/HomeTab/presentation/cubit/movies_cubit.dart'
    as _i336;
import 'package:movies_app/features/home_screen/tabs/profile_tab/data/repositories/reset_password_repo/reset_password_repo.dart'
    as _i67;
import 'package:movies_app/features/home_screen/tabs/profile_tab/data/repositories/reset_password_repo/reset_password_repo_impl.dart'
    as _i587;
import 'package:movies_app/features/home_screen/tabs/profile_tab/presentation/cubit/reset_password_cubite/reset_password_cubite.dart'
    as _i139;
import 'package:movies_app/features/home_screen/tabs/profile_tab/rest_data/rest_data_source.dart'
    as _i543;
import 'package:movies_app/features/home_screen/tabs/profile_tab/rest_data/rest_data_source_impl.dart'
    as _i737;
import 'package:movies_app/features/movie_details/api/dataSource_impl/details_data_source_impl.dart'
    as _i109;
import 'package:movies_app/features/movie_details/api/movie_details_api.dart'
    as _i790;
import 'package:movies_app/features/movie_details/data/data_source/details_data_source.dart'
    as _i1035;
import 'package:movies_app/features/movie_details/data/repo_impl/movie_details_repo_impl.dart'
    as _i333;
import 'package:movies_app/features/movie_details/domain/repo/movie_details_repo.dart'
    as _i718;
import 'package:movies_app/features/movie_details/presentation/cubit/cubit_movie_details.dart'
    as _i880;
import 'package:movies_app/features/movie_details/presentation/cubit/fav_cubit/FavoriteCubit.dart'
    as _i491;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final dioModule = _$DioModule();
    gh.singleton<_i749.ApiManagerHomeTab>(() => _i749.ApiManagerHomeTab());
    gh.lazySingleton<_i361.Dio>(() => dioModule.dio());
    gh.lazySingleton<_i790.MovieDetailsApi>(() => _i790.MovieDetailsApi());
    gh.factory<_i325.MoviesDataSource>(
      () => _i916.MoviesDataSourceImpl(gh<_i749.ApiManagerHomeTab>()),
    );
    gh.factory<_i509.MoviesReposatry>(
      () => _i807.MoviesReposatryImpl(gh<_i325.MoviesDataSource>()),
    );
    gh.lazySingleton<_i1035.DetailsDataSource>(
      () => _i109.DetailsDataSourceImpl(gh<_i790.MovieDetailsApi>()),
    );
    gh.lazySingleton<_i718.MovieDetailsRepo>(
      () => _i333.MovieDetailsRepositoryImpl(
        dataSource: gh<_i1035.DetailsDataSource>(),
      ),
    );
    gh.lazySingleton<_i543.RestDataSource>(
      () => _i737.RestDataSourceImpl(dio: gh<_i361.Dio>()),
    );
    gh.factory<_i880.CubitMovieDetails>(
      () => _i880.CubitMovieDetails(gh<_i718.MovieDetailsRepo>()),
    );
    gh.factory<_i491.FavoriteCubit>(
      () => _i491.FavoriteCubit(gh<_i718.MovieDetailsRepo>()),
    );
    gh.factory<_i336.MoviesCubit>(
      () => _i336.MoviesCubit(gh<_i509.MoviesReposatry>()),
    );
    gh.lazySingleton<_i67.ResetPasswordRepo>(
      () => _i587.ResetPasswordRepoImpl(dataSource: gh<_i543.RestDataSource>()),
    );
    gh.factory<_i139.ResetPasswordCubit>(
      () => _i139.ResetPasswordCubit(
        resetPasswordRepo: gh<_i67.ResetPasswordRepo>(),
      ),
    );
    return this;
  }
}

class _$DioModule extends _i660.DioModule {}
