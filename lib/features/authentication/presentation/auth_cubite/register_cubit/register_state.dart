import 'package:movies_app/features/authentication/domain/entity/auth_result.dart';

class RegisterState {}

class RegisterInitialState extends RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterSuccessState extends RegisterState {
  final AuthResult result;
  RegisterSuccessState({required this.result});
}

class RegisterFailureState extends RegisterState {
  final String errMessage;
  RegisterFailureState({required this.errMessage});
}
