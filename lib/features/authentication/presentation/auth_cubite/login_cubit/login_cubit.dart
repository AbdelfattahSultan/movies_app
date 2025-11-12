import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/authentication/domain/auth_%20repository/auth_%20repository.dart';
import 'package:movies_app/features/authentication/presentation/auth_cubite/login_cubit/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.authRepository) : super(LoginInitialState());

  final AuthRepository authRepository;

  Future<void> login({required String email, required String password}) async {
    try {
      if (!isClosed) emit(LoginLoadingState());

      final result = await authRepository.login(
        email: email,
        password: password,
      );

      result.fold(
        (l) {
          if (!isClosed) emit(LoginFailureState(errMessage: l.errMessage));
        },
        (r) {
          if (!isClosed) emit(LoginSuccessState(loginModel: r));
        },
      );
    } catch (e) {
      if (!isClosed) emit(LoginFailureState(errMessage: e.toString()));
    }
  }
}
