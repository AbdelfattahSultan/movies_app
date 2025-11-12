import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:movies_app/core/errors/failure.dart';
import 'package:movies_app/features/authentication/data/auth_data_source/auth_data_source.dart';
import 'package:movies_app/features/authentication/data/models/login_model/login_model.dart';
import 'package:movies_app/features/authentication/domain/auth_%20repository/auth_%20repository.dart';
import 'package:movies_app/features/authentication/domain/entity/auth_result.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthDataSource authDataSource;
  AuthRepositoryImpl({required this.authDataSource});
  @override
  Future<Either<Failure, AuthResult>> register({
    required String name,
    required String email,
    required String password,
    required String phone,
    required int avatarId,
  }) async {
    try {
      var result = await authDataSource.register(
        name: name,
        email: email,
        password: password,
        phone: phone,
        avatarId: avatarId,
      );
      return Right(result.toEntity());
    } on DioException catch (e) {
      return Left(Failure(errMessage: e.response?.data["message"]));
    }
  }

  @override
  Future<Either<Failure, LoginModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      var result = await authDataSource.login(email: email, password: password);
      return Right(result);
    } on DioException catch (e) {
      return Left(Failure(errMessage: e.response?.data["message"]));
    }
  }
}
