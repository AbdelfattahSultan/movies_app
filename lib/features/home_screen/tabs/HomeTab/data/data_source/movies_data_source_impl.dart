import 'package:injectable/injectable.dart';
import 'package:movies_app/features/home_screen/tabs/HomeTab/api/Api_manger.dart';
import 'package:movies_app/features/home_screen/tabs/HomeTab/data/data_source/movies_data_source.dart';
import 'package:movies_app/features/home_screen/tabs/HomeTab/domain/model/movie.dart';

@Injectable(as: MoviesDataSource)
class MoviesDataSourceImpl implements MoviesDataSource {
  final ApiManagerHomeTab apiManager;
  MoviesDataSourceImpl(this.apiManager);
  @override
  Future<List<Movie>> getTopMovies() async {
    return await apiManager.getTopMovies();
  }

  @override
  Future<List<Movie>> getMoviesByGenre(int limit, String genre) async {
    return await apiManager.getMoviesByGenre(limit, genre);
  }
}
