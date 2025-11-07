// ignore: file_names
import 'package:dartz/dartz.dart';
import 'package:movies_app/core/errors/failure.dart';
import 'package:movies_app/features/authentication/data/models/login_model/login_model.dart';
import 'package:movies_app/features/authentication/domain/entity/auth_result.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthResult>> register({
    required String name,
    required String email,
    required String password,
    required String phone,
    required int avatarId,
  });

    Future<Either<Failure, LoginModel>> login({
    required String email,
    required String password,
  });
}
