import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_app/features/movie_details/domain/repo/movie_details_repo.dart';
import 'package:movies_app/features/movie_details/presentation/cubit/cubit_movie_details_state.dart';

@injectable
class CubitMovieDetails extends Cubit<CubitMovieDetailsState> {
  final MovieDetailsRepo movieDetailsRepo;

  CubitMovieDetails(this.movieDetailsRepo) : super(MovieDetailsInitialState());

  static CubitMovieDetails get(context) => BlocProvider.of(context);

  Future<void> loadMovie(String movieId) async {
    emit(MovieDetailsLoadingState());
    try {
      final movieDetails = await movieDetailsRepo.getMovieDetails(movieId);
      final similar = await movieDetailsRepo.getMovieSuggestions(movieId);
      emit(
        MovieDetailsSuccessState(
          movieDetails: movieDetails,
          similarMovies: similar,
        ),
      );
    } catch (e) {
      emit(MovieDetailsErrorState(e.toString()));
    }
  }
}
