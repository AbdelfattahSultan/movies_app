import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_app/features/home_screen/tabs/profile_tab/rest_data/rest_data_source.dart';
@LazySingleton(as: RestDataSource)
class RestDataSourceImpl implements RestDataSource {
  final Dio dio;
  RestDataSourceImpl({required this.dio});

  @override
  Future<bool> resetPassword({
    required String oldPassword,
    required String newPassword,
    required String token,
  }) async {
    final data = {"oldPassword": oldPassword, "newPassword": newPassword};
    final response = await dio.patch(
      "https://route-movie-apis.vercel.app/auth/reset-password",
      data: data,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    if (response.statusCode == 200) return true;
    throw Exception("Failed to reset password");
  }
}
