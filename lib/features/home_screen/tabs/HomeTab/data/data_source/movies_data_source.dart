import 'package:movies_app/features/home_screen/tabs/HomeTab/domain/model/movie.dart';

abstract class MoviesDataSource {
  Future<List<Movie>> getTopMovies(int limit,String dateAdd);
  Future<List<Movie>> getMoviesByGenre(int limit,String genre);

}