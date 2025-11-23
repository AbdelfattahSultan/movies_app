import 'package:injectable/injectable.dart';
import 'package:movies_app/features/home_screen/tabs/HomeTab/domain/model/movie.dart';
import 'package:movies_app/features/home_screen/tabs/search_tab/api/search_api.dart';
import 'package:movies_app/features/home_screen/tabs/search_tab/data/search_data_source/search_data_source.dart';

@LazySingleton(as: SearchDataSource)
class SearchDataSourceImpl implements SearchDataSource {
  SearchApi searchApi;
  SearchDataSourceImpl(this.searchApi);
  @override
  Future<List<Movie>> searchMovies(String query) async {
    return await searchApi.searchMovies(query);
  }
}
