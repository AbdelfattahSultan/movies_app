import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/authentication/domain/auth_%20repository/auth_%20repository.dart';
import 'package:movies_app/features/authentication/presentation/auth_cubite/register_cubit/register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this.authRepository) : super(RegisterInitialState());

  AuthRepository authRepository;

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String phone,
    required int avatarId,
  }) async {
    try {
      String normalizedPhone = phone
          .trim()
          .replaceAll('+', '')
          .replaceAll(' ', '');
      if (normalizedPhone.startsWith('0')) {
        normalizedPhone = '+20${normalizedPhone.substring(1)}';
      } else if (!normalizedPhone.startsWith('+20')) {
        normalizedPhone = '+20$normalizedPhone';
      }
      emit(RegisterLoadingState());
      final result = await authRepository.register(
        name: name,
        email: email,
        password: password,
        phone: normalizedPhone,
        avatarId: avatarId,
      );
      result.fold(
        (l) => emit(RegisterFailureState(errMessage: l.errMessage)),
        (r) => emit(RegisterSuccessState(result: r)),
      );
    } catch (e) {
      emit(RegisterFailureState(errMessage: e.toString()));
    }
  }
}
