import 'package:injectable/injectable.dart';
import 'package:movies_app/features/home_screen/tabs/HomeTab/domain/model/movie.dart';
import 'package:movies_app/features/home_screen/tabs/search_tab/data/search_data_source/search_data_source.dart';
import 'package:movies_app/features/home_screen/tabs/search_tab/domain/repo/search_repo.dart';

@LazySingleton(as: SearchRepo)
class SearchRepoImpl implements SearchRepo {
  final SearchDataSource searchDataSource;

  SearchRepoImpl(this.searchDataSource);

  @override
  Future<List<Movie>> searchMovies(String query) async {
    return await searchDataSource.searchMovies(query);
  }
}
