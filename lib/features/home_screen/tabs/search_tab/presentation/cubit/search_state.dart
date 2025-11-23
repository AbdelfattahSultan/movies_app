import 'package:movies_app/features/home_screen/tabs/HomeTab/domain/model/movie.dart';


abstract class SearchState {}

class InitState extends SearchState {}

class LoadingState extends SearchState {}

class SuccessState extends SearchState {
  final List<Movie> movies;

  SuccessState(this.movies);
}

class ErrorState extends SearchState {
  final String message;

  ErrorState(this.message);
}

class EmptyState extends SearchState {
  final String message;

  EmptyState(this.message);
}
