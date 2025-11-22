import 'package:injectable/injectable.dart';
import 'package:movies_app/features/home_screen/tabs/HomeTab/domain/model/movie.dart';
import 'package:movies_app/features/movie_details/api/model/respone/details_respone/movie.dart';
import 'package:movies_app/features/movie_details/api/model/respone/favorites_response/favrites_response/favrites_response.dart';
import 'package:movies_app/features/movie_details/data/data_source/details_data_source.dart';
import 'package:movies_app/features/movie_details/domain/repo/movie_details_repo.dart';

@LazySingleton(as: MovieDetailsRepo)
class MovieDetailsRepositoryImpl implements MovieDetailsRepo {
  final DetailsDataSource dataSource;

  MovieDetailsRepositoryImpl({required this.dataSource});

  @override
  Future<MovieDetails> getMovieDetails(String movieId) {
    return dataSource.getMovieDetails(movieId);
  }

  @override
  Future<List<Movie>> getMovieSuggestions(String? movieId) {
    return dataSource.getMovieSuggestions(movieId);
  }

  @override
Future<FavoritesResponse> addMovieToFavorite({
    required String movieId,
    required String name,
    required double rating,
    required String imageURL,
    required String year,
  }) async {
    return await dataSource.addMovieToFavorite(
      movieId: movieId,
      name: name,
      rating: rating,
      imageURL: imageURL,
      year: year,
    );
  }
  
  @override
  Future<bool> isMovieFavorite(String movieId)async {
    return await dataSource.isMovieFavorite(movieId);
  }
  
  @override
  Future<bool> deleteFromFavorite(String movieId) async{
  return await dataSource.deleteFromFavorite(movieId);
  }
  
}
