import 'package:movies_app/features/home_screen/tabs/HomeTab/domain/model/movie.dart';

abstract class MoviesState {}

class MoviesInti extends MoviesState {}

class MoviesLoading extends MoviesState {}

class MoviesSuccess extends MoviesState {
  final List<Movie> topMovies;
  final Map<String, List<Movie>> genreMoviesMap;

  MoviesSuccess(this.topMovies, this.genreMoviesMap);
}

class MoviesError extends MoviesState {
  final String error;
  MoviesError(this.error);
}
