import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_app/features/home_screen/tabs/HomeTab/data/respone/MoviesRespone.dart';
import 'package:movies_app/features/home_screen/tabs/HomeTab/domain/model/movie.dart';

@singleton
class ApiManagerHomeTab {
  final _dio = Dio();
  ApiManagerHomeTab() {
    _dio;
  }
  Future<List<Movie>> getTopMovies() async {
    var q = {"limit": 10, "sort_by": "download_count", "order_by": "desc"};
    var response = await _dio.get(
      "https://yts.lt/api/v2/list_movies.json",
      queryParameters: q,
    );
    MoviesResponse moviesResponse = MoviesResponse.fromJson(response.data);
    return moviesResponse.data.movies.map((e) => e.toMovie()).toList();
  }

  Future<List<Movie>> getMoviesByGenre(int limit, String genre) async {
    var q = {"limit": limit, "genre": genre};
    var response = await _dio.get(
      "https://yts.lt/api/v2/list_movies.json",
      queryParameters: q,
    );
    MoviesResponse moviesResponse = MoviesResponse.fromJson(response.data);
    return moviesResponse.data.movies.map((e) => e.toMovie()).toList();
  }
}
