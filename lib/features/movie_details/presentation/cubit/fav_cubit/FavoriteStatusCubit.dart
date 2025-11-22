import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/movie_details/domain/repo/movie_details_repo.dart';

class FavoriteStatusCubit extends Cubit<bool> {
  final MovieDetailsRepo repo;

  FavoriteStatusCubit(this.repo) : super(false);

  Future<void> checkIfFavorite(String movieId) async {
    final isFav = await repo.isMovieFavorite(movieId);
    emit(isFav);
  }
}
