import 'package:injectable/injectable.dart';
import 'package:movies_app/features/home_screen/tabs/HomeTab/data/data_source/movies_data_source.dart';
import 'package:movies_app/features/home_screen/tabs/HomeTab/domain/model/movie.dart';
import 'package:movies_app/features/home_screen/tabs/HomeTab/domain/repositories/movies_reposatry.dart';
@Injectable(as: MoviesReposatry)
class MoviesReposatryImpl implements MoviesReposatry {
  MoviesDataSource moviesDataSource;
  MoviesReposatryImpl(this.moviesDataSource);
  @override
  Future<List<Movie>> getTopMovies(int limit, String dateAdd) async {
    return await moviesDataSource.getTopMovies(limit, dateAdd);
  }
    @override
  Future<List<Movie>> getMoviesByGenre(int limit, String genre) async {

      return await moviesDataSource.getMoviesByGenre(limit, genre);

    }
  }

