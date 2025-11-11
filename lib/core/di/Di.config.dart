// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/home_screen/tabs/HomeTab/api/Api_manger.dart' as _i755;
import '../../features/home_screen/tabs/HomeTab/data/data_source/movies_data_source.dart'
    as _i195;
import '../../features/home_screen/tabs/HomeTab/data/data_source/movies_data_source_impl.dart'
    as _i393;
import '../../features/home_screen/tabs/HomeTab/data/reposatry/movies_reposatry_impl.dart'
    as _i785;
import '../../features/home_screen/tabs/HomeTab/domain/repositories/movies_reposatry.dart'
    as _i482;
import '../../features/home_screen/tabs/HomeTab/presentation/cubit/movies_cubit.dart' as _i310;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.singleton<_i755.ApiManagerHomeTab>(() => _i755.ApiManagerHomeTab());
    gh.factory<_i195.MoviesDataSource>(
      () => _i393.MoviesDataSourceImpl(gh<_i755.ApiManagerHomeTab>()),
    );
    gh.factory<_i482.MoviesReposatry>(
      () => _i785.MoviesReposatryImpl(gh<_i195.MoviesDataSource>()),
    );
    gh.factory<_i310.MoviesCubit>(
      () => _i310.MoviesCubit(gh<_i482.MoviesReposatry>()),
    );
    return this;
  }
}
