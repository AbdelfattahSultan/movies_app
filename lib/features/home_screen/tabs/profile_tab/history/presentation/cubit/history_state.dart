import 'package:equatable/equatable.dart';
import 'package:movies_app/features/home_screen/tabs/HomeTab/domain/model/movie.dart';

abstract class HistoryState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HistoryInitial extends HistoryState {}

class HistoryLoaded extends HistoryState {
  final List<Movie> movies;

  HistoryLoaded(this.movies);

  @override
  List<Object?> get props => [movies];
}
