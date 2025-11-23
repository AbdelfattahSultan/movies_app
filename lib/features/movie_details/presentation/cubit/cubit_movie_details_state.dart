import 'package:movies_app/features/home_screen/tabs/HomeTab/domain/model/movie.dart';
import 'package:movies_app/features/movie_details/api/model/respone/details_respone/movie.dart';

class CubitMovieDetailsState {}

class MovieDetailsInitialState extends CubitMovieDetailsState {}

class MovieDetailsLoadingState extends CubitMovieDetailsState {}

class MovieDetailsSuccessState extends CubitMovieDetailsState {
  final MovieDetails movieDetails;
  final List<Movie> similarMovies;

  MovieDetailsSuccessState({
    required this.movieDetails,
    required this.similarMovies,
  });
}

class MovieDetailsErrorState extends CubitMovieDetailsState {
  final String error;

  MovieDetailsErrorState(this.error);
}
