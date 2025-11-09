import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_app/features/HomeTab/data/respone/MoviesRespone.dart';
import 'package:movies_app/features/HomeTab/domain/model/movie.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
@singleton
class ApiManagerHomeTab {
  final _dio = Dio();
  ApiManagerHomeTab() {
    _dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
      ),
    );
  }
  Future<List<Movie>> getTopMovies(int limit,String dateAdd) async {
    var q = {
      "limit": limit,
      "sort_by": dateAdd,
    };
    var response = await _dio.get("https://yts.mx/api/v2/list_movies.json",
        queryParameters: q);
   MoviesResponse moviesResponse = MoviesResponse.fromJson(response.data);
    return moviesResponse.data.movies.map((e) => e.toMovie()).toList();

  }

  Future<List<Movie>> getMoviesByGenre(int limit,String genre) async {
    var q = {
      "limit": limit,
      "genre": genre,
    };
    var response = await _dio.get("https://yts.mx/api/v2/list_movies.json",
        queryParameters: q);
    MoviesResponse moviesResponse = MoviesResponse.fromJson(response.data);
    return moviesResponse.data.movies.map((e) => e.toMovie()).toList();

  }
}