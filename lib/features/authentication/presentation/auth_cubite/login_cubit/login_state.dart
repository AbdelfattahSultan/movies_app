import 'package:movies_app/features/authentication/data/models/login_model/login_model.dart';

class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  final LoginModel loginModel;
  LoginSuccessState({required this.loginModel});
}

class LoginFailureState extends LoginState {
  final String errMessage;
  LoginFailureState({required this.errMessage});
}
