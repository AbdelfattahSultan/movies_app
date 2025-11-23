import 'package:dio/dio.dart';
import 'package:movies_app/core/utils/token_helper.dart';
import 'package:movies_app/features/home_screen/tabs/HomeTab/domain/model/movie.dart';
import 'favorites_data_source.dart';

class FavoritesDataSourceImpl implements FavoritesDataSource {
  final Dio dio;

  FavoritesDataSourceImpl(this.dio);

  @override
  Future<void> addToFavorite(int movieId) async {
    final token = await TokenHelper.getToken();

    await dio.post(
      '/favorites/add',
      data: {"movieId": movieId},
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
  }

  @override
  Future<void> removeFromFavorite(int movieId) async {
    final token = await TokenHelper.getToken();

    await dio.delete(
      '/favorites/remove/$movieId',
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
  }

  @override
  Future<bool> isFavorite(int movieId) async {
    final token = await TokenHelper.getToken();
    final res = await dio.get(
      '/favorites/is-favorite/$movieId',
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );

    return res.data?["data"] == true;
  }

  @override
  Future<List<Movie>> getAllFavorites() async {
    final token = await TokenHelper.getToken();

    final res = await dio.get(
      '/favorites/all',
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );

    final list = (res.data["data"] as List);

    return list.map((json) {
      return Movie(
        id: json["movieId"],
        title: json["name"],
        rating: double.tryParse(json["rating"].toString()) ?? 0.0,
        image: json["imageURL"],
        year: int.tryParse(json["year"].toString()) ?? 0,
        genres: const [],
      );
    }).toList();
  }
}
