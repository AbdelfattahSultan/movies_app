import 'package:movies_app/features/home_screen/tabs/HomeTab/domain/model/movie.dart';

abstract class SearchDataSource {
  Future<List<Movie>> searchMovies(String query);
}
