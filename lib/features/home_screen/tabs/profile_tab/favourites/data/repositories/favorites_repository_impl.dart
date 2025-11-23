
import '../data_source/favorites_data_source.dart';
import 'favorites_repository.dart';
import 'package:movies_app/features/home_screen/tabs/HomeTab/domain/model/movie.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesDataSource dataSource;

  FavoritesRepositoryImpl(this.dataSource);

  @override
  Future<void> addFavorite(int movieId) async {
    await dataSource.addToFavorite(movieId);
  }

  @override
  Future<void> removeFavorite(int movieId) async {
    await dataSource.removeFromFavorite(movieId);
  }

  @override
  Future<bool> checkFavorite(int movieId) {
    return dataSource.isFavorite(movieId);
  }

  @override
  Future<List<Movie>> getFavorites() {
    return dataSource.getAllFavorites();
  }
}
