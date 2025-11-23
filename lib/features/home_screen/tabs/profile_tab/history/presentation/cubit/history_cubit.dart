import 'package:flutter_bloc/flutter_bloc.dart';
import 'history_state.dart';
import '../../data/history_local_data_source.dart';
import 'package:movies_app/features/home_screen/tabs/HomeTab/domain/model/movie.dart';

class HistoryCubit extends Cubit<HistoryState> {
  final HistoryLocalDataSource dataSource;

  HistoryCubit(this.dataSource) : super(HistoryInitial());

  Future<void> loadHistory() async {
    final movies = await dataSource.getHistory();
    emit(HistoryLoaded(movies));
  }

  Future<void> addMovie(Movie movie) async {
    await dataSource.saveMovie(movie);
    await loadHistory();
  }
}
