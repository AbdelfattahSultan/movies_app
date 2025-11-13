import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_app/features/home_screen/tabs/profile_tab/data/repositories/reset_password_repo/reset_password_repo.dart';

import 'reset_password_state.dart';

@injectable
class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordRepo resetPasswordRepo;
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  ResetPasswordCubit({required this.resetPasswordRepo})
    : super(ResetPasswordInitial());

  Future<void> resetPassword({
    required String oldPassword,
    required String newPassword,
    required String token,
  }) async {
    emit(ResetPasswordLoading());
    try {
      final success = await resetPasswordRepo.resetPassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
        token: token,
      );
      if (success) {
        emit(ResetPasswordSuccess(message: "Password changed successfully"));
      } else {
        emit(ResetPasswordFailure(errMessage: "Failed to reset password"));
      }
    } catch (e) {
      emit(ResetPasswordFailure(errMessage: e.toString()));
    }
  }
}
