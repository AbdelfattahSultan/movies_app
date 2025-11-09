import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/authentication/domain/auth_%20repository/auth_%20repository.dart';
import 'package:movies_app/features/authentication/presentation/auth_cubite/login_cubit/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.authRepository) : super(LoginInitialState());

  AuthRepository authRepository;

  Future<void> login({required String email, required String password}) async {
    try {
      emit(LoginLoadingState());
      final result = await authRepository.login(
        email: email,
        password: password,
      );
      result.fold(
        (l) => emit(LoginFailureState(errMessage: l.errMessage)),
        (r) => emit(LoginSuccessState(loginModel: r)),
      );
    } catch (e) {
      emit(LoginFailureState(errMessage: e.toString()));
    }
  }
}
