class LoginModel {
  String? message;
  String? token;

  LoginModel({this.message, this.token});

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    message: json['message'] as String?,
    token: json['data'] as String?,
  );

  Map<String, dynamic> toJson() => {'message': message, 'data': token};
}
