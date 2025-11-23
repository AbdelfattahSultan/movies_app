import 'package:movies_app/features/home_screen/tabs/HomeTab/domain/model/movie.dart';

abstract class FavoritesRepository {
  Future<void> addFavorite(int movieId);
  Future<void> removeFavorite(int movieId);
  Future<bool> checkFavorite(int movieId);
  Future<List<Movie>> getFavorites();
}
