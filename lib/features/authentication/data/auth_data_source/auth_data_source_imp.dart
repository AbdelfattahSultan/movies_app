import 'package:dio/dio.dart';
import 'package:movies_app/features/authentication/data/auth_data_source/auth_data_source.dart';
import 'package:movies_app/features/authentication/data/models/login_model/login_model.dart';
import 'package:movies_app/features/authentication/data/models/register_model/register_model.dart';

class AuthDataSourceImp implements AuthDataSource {
  Dio dio;
  AuthDataSourceImp({required this.dio});
  @override
  Future<RegisterModel> register({
    required String name,
    required String email,
    required String password,
    required String phone,
    required int avatarId,
  }) async {
    try {
      var data = {
        "name": name,
        "email": email,
        "password": password,
        "confirmPassword": password,
        "phone": phone,
        "avaterId": avatarId,
      };
      print(data);
      final response = await dio.post(
        "https://route-movie-apis.vercel.app/auth/register",
        data: data,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return RegisterModel.fromJson(response.data);
      } else {
        throw Exception("Failed to register user: ${response.statusCode}");
      }
    } on DioException catch (e) {
      throw Exception("Dio error: ${e.response?.data ?? e.message}");
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }

  @override
  Future<LoginModel> login({
    required String email,
    required String password,
  }) async {
    try {
      var data = {"email": email, "password": password};
      print(data);
      final response = await dio.post(
        "https://route-movie-apis.vercel.app/auth/login",
        data: data,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return LoginModel.fromJson(response.data);
      } else {
        throw Exception("Failed to register user: ${response.statusCode}");
      }
    } on DioException catch (e) {
      throw Exception("Dio error: ${e.response?.data ?? e.message}");
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }
}
