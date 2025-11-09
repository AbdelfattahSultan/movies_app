import 'package:movies_app/features/authentication/domain/entity/auth_result.dart';

import 'user_model.dart';

class RegisterModel {
  String? message;
  UserModel? user;

  RegisterModel({this.message, this.user});

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
    message: json['message'] as String?,
    user: json['data'] == null
        ? null
        : UserModel.fromJson(json['data'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {'message': message, 'data': user?.toJson()};

  AuthResult toEntity() {
    return AuthResult(message: message, user: user?.toEntity());
  }
}
