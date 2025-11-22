import 'package:movies_app/features/home_screen/tabs/HomeTab/domain/model/movie.dart';
import 'package:movies_app/features/movie_details/api/model/respone/details_respone/movie.dart';
import 'package:movies_app/features/movie_details/api/model/respone/favorites_response/favrites_response/favrites_response.dart';

abstract class DetailsDataSource {
  Future<MovieDetails> getMovieDetails(String movieId);
  Future<List<Movie>> getMovieSuggestions(String? movieId);
  Future<FavoritesResponse> addMovieToFavorite({
    required String movieId,
    required String name,
    required double rating,
    required String imageURL,
    required String year,
  });
  Future<bool> isMovieFavorite(String movieId);
  Future<bool> deleteFromFavorite(String movieId);
}
