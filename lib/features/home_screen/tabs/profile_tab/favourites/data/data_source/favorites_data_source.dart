import 'package:movies_app/features/home_screen/tabs/HomeTab/domain/model/movie.dart';

abstract class FavoritesDataSource {
  Future<void> addToFavorite(int movieId);
  Future<void> removeFromFavorite(int movieId);
  Future<bool> isFavorite(int movieId);
  Future<List<Movie>> getAllFavorites();
}
