import 'package:equatable/equatable.dart';
import 'package:movies_app/features/home_screen/tabs/HomeTab/domain/model/movie.dart';

abstract class FavoritesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FavoritesInitial extends FavoritesState {}

class FavoritesLoading extends FavoritesState {}

class FavoritesLoaded extends FavoritesState {
  final List<Movie> movies;

  FavoritesLoaded(this.movies);

  @override
  List<Object?> get props => [movies];
}

class FavoritesError extends FavoritesState {
  final String message;

  FavoritesError(this.message);

  @override
  List<Object?> get props => [message];
}
