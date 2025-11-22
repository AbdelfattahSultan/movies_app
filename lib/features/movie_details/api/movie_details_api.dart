import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_app/core/utils/token_helper.dart';
import 'package:movies_app/features/home_screen/tabs/HomeTab/domain/model/movie.dart';
import 'package:movies_app/features/movie_details/api/model/respone/details_respone/details_respone.dart';
import 'package:movies_app/features/movie_details/api/model/respone/details_respone/movie.dart';
import 'package:movies_app/features/movie_details/api/model/respone/favorites_response/FavoriteStatusResponse/FavoriteStatusResponse.dart';
import 'package:movies_app/features/movie_details/api/model/respone/favorites_response/favrites_response/favrites_response.dart';
import 'package:movies_app/features/movie_details/api/model/respone/suggestions_respone/suggestions_respone/suggestions_respone.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@LazySingleton()
class MovieDetailsApi {
  final _dio = Dio();
  MovieDetailsApi() {
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

  Future<MovieDetails> getMovieDetails(String? movieId) async {
    try {
      final response = await _dio.get(
        "https://yts.lt/api/v2/movie_details.json",
        queryParameters: {
          "movie_id": movieId,
          "with_images": true,
          "with_cast": true,
        },
      );

      final detailsResponse = DetailsResponse.fromJson(response.data);
      return detailsResponse.data!.movie!;
    } on DioException catch (e) {
      throw Exception("Network Error: ${e.message}");
    } catch (e) {
      throw Exception("Unexpected Error: $e");
    }
  }

  Future<List<Movie>> getMovieSuggestions(String? movieId) async {
    try {
      final response = await _dio.get(
        "https://yts.lt/api/v2/movie_suggestions.json",
        queryParameters: {"movie_id": movieId, "limit": 4},
      );

      SuggestionsResponse similar = SuggestionsResponse.fromJson(response.data);
      return similar.data?.movies?.map((e) => e.toMovie()).toList() ?? [];
    } on DioException catch (e) {
      throw Exception("Network Error: ${e.message}");
    } catch (e) {
      throw Exception("Unexpected Error: $e");
    }
  }

  Future<FavoritesResponse> addMovieToFavorite({
    required String movieId,
    required String name,
    required double rating,
    required String imageURL,
    required String year,
  }) async {
    try {
      final token = await TokenHelper.getToken();

      final data = {
        "movieId": movieId,
        "name": name,
        "rating": rating.round(),
        "imageURL": imageURL,
        "year": year,
      };

      final response = await _dio.post(
        "https://route-movie-apis.vercel.app/favorites/add",
        data: data,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
          },
        ),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception("Server returned: ${response.statusCode}");
      }

      return FavoritesResponse.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(
          "Server Error: ${e.response?.data?['message'] ?? e.message}",
        );
      } else {
        throw Exception("Network Error: ${e.message}");
      }
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }

  Future<bool> isMovieFavorite(String movieId) async {
    final token = await TokenHelper.getToken();

    final response = await _dio.get(
      "https://route-movie-apis.vercel.app/favorites/is-favorite/$movieId",
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );

    return FavoriteStatusResponse.fromJson(response.data).isFavorite;
  }

Future<bool> deleteFromFavorite(String movieId) async {
  final token = await TokenHelper.getToken();

  try {
    final response = await _dio.delete(
      "https://route-movie-apis.vercel.app/favorites/remove/$movieId",
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
        },
      ),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    }

    final msg = response.data["message"]?.toString().toLowerCase() ?? "";
    if (msg.contains("removed")) {
      return true;
    }

    return false;
  } on DioException catch (e) {
    if (e.response != null) {
      throw Exception(
        "Server error: ${e.response?.data?['message'] ?? e.message}",
      );
    } else {
      throw Exception("Network error: ${e.message}");
    }
  } catch (e) {
    throw Exception("Unexpected error: $e");
  }
}



}
