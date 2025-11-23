import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_app/features/home_screen/tabs/search_tab/domain/repo/search_repo.dart';
import 'package:movies_app/features/home_screen/tabs/search_tab/presentation/cubit/search_state.dart';
@injectable
class SearchCubit extends Cubit<SearchState> {
  SearchRepo searchRepo;
  SearchCubit(this.searchRepo) : super(InitState());

  TextEditingController controller = TextEditingController();

  Future<void> searchMovies() async {
    try {
      emit(LoadingState());
      var response = await searchRepo.searchMovies(controller.text);
      if (response.isEmpty) {
        emit(EmptyState("is empty"));
      } else {
        emit(SuccessState(response));
      }
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }

  void clear() {
    controller.clear();
    emit(InitState());
  }
}
