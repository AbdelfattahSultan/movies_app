import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_app/features/movie_details/api/model/respone/favorites_response/favrites_response/favrites_response.dart';
import 'package:movies_app/features/movie_details/domain/repo/movie_details_repo.dart';
import 'package:movies_app/features/movie_details/presentation/cubit/fav_cubit/FavoriteState.dart';

@injectable
class FavoriteCubit extends Cubit<FavoriteState> {
  final MovieDetailsRepo movieDetailsRepo;
  bool isFavorite = false;

  FavoriteCubit(this.movieDetailsRepo) : super(FavoriteInitial());


  Future<void> checkIsFavorite(String movieId) async {
    try {
      final result = await movieDetailsRepo.isMovieFavorite(movieId);
      isFavorite = result;
      emit(FavoriteStatusLoaded(isFavorite));
    } catch (e) {
      emit(FavoriteError(e.toString()));
    }
  }


  Future<void> addMovieToFavorite({
    required String movieId,
    required String name,
    required double rating,
    required String imageURL,
    required String year,
  }) async {
    emit(FavoriteLoading());
    try {
      final FavoritesResponse response =
          await movieDetailsRepo.addMovieToFavorite(
        movieId: movieId,
        name: name,
        rating: rating,
        imageURL: imageURL,
        year: year,
      );

      final message =
          response.message ?? "Movie added to favorites successfully";

      isFavorite = true;
      emit(FavoriteStatusLoaded(isFavorite));
      emit(FavoriteSuccess(message));
    } catch (e) {
      emit(FavoriteError(e.toString()));
    }
  }


  Future<void> removeMovieFromFavorite(String movieId) async {
    emit(FavoriteLoading());
    try {
      final success = await movieDetailsRepo.deleteFromFavorite(movieId);

      if (success) {
        isFavorite = false;
        emit(FavoriteStatusLoaded(isFavorite));
        emit(FavoriteSuccess("Movie removed from favorites"));
      } else {
        emit(FavoriteError("Failed to remove movie from favorites"));
      }
    } catch (e) {
      emit(FavoriteError(e.toString()));
    }
  }

  Future<void> toggleFavorite({
    required String movieId,
    required String name,
    required double rating,
    required String imageURL,
    required String year,
  }) async {
    if (isFavorite) {
      await removeMovieFromFavorite(movieId);
    } else {
      await addMovieToFavorite(
        movieId: movieId,
        name: name,
        rating: rating,
        imageURL: imageURL,
        year: year,
      );
    }
  }
}
