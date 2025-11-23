import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_app/features/home_screen/tabs/HomeTab/data/respone/MoviesRespone.dart';
import 'package:movies_app/features/home_screen/tabs/HomeTab/domain/model/movie.dart';

@LazySingleton()
class SearchApi {
  final Dio _dio;

  SearchApi(this._dio);

  Future<List<Movie>> searchMovies(String query) async {
    try {
      final response = await _dio.get(
        'https://yts.lt/api/v2/list_movies.json',
        queryParameters: {
          'query_term': query,
          'limit': 50,
          'sort_by': 'download_count',
          'order_by': 'desc',
          'minimum_rating': 5,
          'quality': 'all',
        },
      );

      if (response.statusCode == 200) {
        MoviesResponse moviesResponse = MoviesResponse.fromJson(response.data);
        return moviesResponse.data.movies.map((e) => e.toMovie()).toList();
      } else {
        throw Exception('Failed to load search results');
      }
    } catch (e) {
      throw Exception('Error searching movies: $e');
    }
  }
}
