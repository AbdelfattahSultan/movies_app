import 'package:movies_app/features/authentication/domain/entity/auth_entity.dart';

class AuthResult {
  final String? message;
  final AuthEntity? user;

  AuthResult({this.message, this.user});
}
