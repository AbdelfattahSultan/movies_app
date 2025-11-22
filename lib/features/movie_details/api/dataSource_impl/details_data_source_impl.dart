import 'package:injectable/injectable.dart';
import 'package:movies_app/features/home_screen/tabs/HomeTab/domain/model/movie.dart';
import 'package:movies_app/features/movie_details/api/model/respone/details_respone/movie.dart';
import 'package:movies_app/features/movie_details/api/model/respone/favorites_response/favrites_response/favrites_response.dart';
import 'package:movies_app/features/movie_details/api/movie_details_api.dart';
import 'package:movies_app/features/movie_details/data/data_source/details_data_source.dart';

@LazySingleton(as: DetailsDataSource)
class DetailsDataSourceImpl implements DetailsDataSource {
  MovieDetailsApi api;
  DetailsDataSourceImpl(this.api);

  @override
  Future<MovieDetails> getMovieDetails(String movieId) async {
    return await api.getMovieDetails(movieId);
  }

  @override
  Future<List<Movie>> getMovieSuggestions(String? movieId) async {
    return await api.getMovieSuggestions(movieId);
  }

  @override
  Future<FavoritesResponse> addMovieToFavorite({
    required String movieId,
    required String name,
    required double rating,
    required String imageURL,
    required String year,
  }) async {
    return await api.addMovieToFavorite(
      movieId: movieId,
      name: name,
      rating: rating,
      imageURL: imageURL,
      year: year,
    );
  }
  
  @override
  Future<bool> isMovieFavorite(String movieId) async{
    return await api.isMovieFavorite(movieId);
  }
  
  @override
  Future<bool> deleteFromFavorite(String movieId) {
    return api.deleteFromFavorite(movieId);
  }
}
