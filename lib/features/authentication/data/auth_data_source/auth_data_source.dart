import 'package:movies_app/features/authentication/data/models/login_model/login_model.dart';
import 'package:movies_app/features/authentication/data/models/register_model/register_model.dart';

abstract class AuthDataSource {
  Future<RegisterModel> register({
    required String name,
    required String email,
    required String password,
    required String phone,
    required int avatarId,
  });

  Future<LoginModel> login({required String email, required String password});
}
