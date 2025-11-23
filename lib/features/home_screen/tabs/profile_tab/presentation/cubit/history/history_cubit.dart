import 'package:bloc/bloc.dart';
import 'package:movies_app/features/home_screen/tabs/HomeTab/domain/model/movie.dart';
import 'package:movies_app/features/home_screen/tabs/profile_tab/data/history/history_data_source.dart';
import 'package:movies_app/features/home_screen/tabs/profile_tab/presentation/cubit/history/history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  final HistoryLocalDataSource dataSource;

  HistoryCubit(this.dataSource) : super(HistoryInitial());

  Future<void> loadHistory() async {
    try {
      final movies = await dataSource.getHistory();
      emit(HistoryLoaded(movies));
    } catch (e) {
      emit(HistoryLoaded([]));
    }
  }

  Future<void> addMovie(Movie movie) async {
    try {
      await dataSource.saveMovie(movie);
      await loadHistory();
    } catch (e) {
      emit(HistoryLoaded([]));
    }
  }
}
