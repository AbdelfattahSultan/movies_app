abstract class FavoriteState {}

class FavoriteInitial extends FavoriteState {}

class FavoriteLoading extends FavoriteState {}

class FavoriteSuccess extends FavoriteState {
  final String message;

  FavoriteSuccess(this.message);
}

class FavoriteError extends FavoriteState {
  final String error;

  FavoriteError(this.error);
}

class FavoriteStatusLoaded extends FavoriteState {
  final bool isFavorite;
  FavoriteStatusLoaded(this.isFavorite);
}

