// [File: movies_app/features/HomeTab/presentation/cubit/movies_cubit.dart]

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_app/features/HomeTab/domain/repositories/movies_reposatry.dart';
import 'package:movies_app/features/HomeTab/presentation/cubit/movies_state.dart';
import 'package:movies_app/features/HomeTab/domain/model/movie.dart'; // تأكد من استيراد Movie

@injectable
class MoviesCubit extends Cubit<MoviesState>{

  final MoviesReposatry moviesReposatry;

  List<Movie> _topMovies = [];
  final Map<String, List<Movie>> _genreMoviesMap = {};

  MoviesCubit(this.moviesReposatry) : super(MoviesInti());

  void getTopMovies(int limit,String dateAdd)async{
    try{
      _topMovies = await  moviesReposatry.getTopMovies(limit, dateAdd);
      emit(MoviesSuccess(_topMovies, _genreMoviesMap));
    }catch(e){
      emit(MoviesError(e.toString()));
    }
  }

  void grtMoviesByGenre(int limit,String genre)async{
    emit(MoviesLoading());
    try{
      var movies = await  moviesReposatry.getMoviesByGenre(limit, genre);

      _genreMoviesMap[genre] = movies;

      emit(MoviesSuccess(_topMovies, _genreMoviesMap));
    }catch(e){
      emit(MoviesError(e.toString()));
    }
  }
}