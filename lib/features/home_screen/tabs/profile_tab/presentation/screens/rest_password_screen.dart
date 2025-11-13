import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/common_widgets/Custom_Text_Filed.dart';
import 'package:movies_app/core/common_widgets/custom_button.dart';
import 'package:movies_app/core/common_widgets/validator.dart';
import 'package:movies_app/core/config/app_colors.dart';
import 'package:movies_app/core/config/app_images.dart';
import 'package:movies_app/core/di/Di.dart';
import 'package:movies_app/core/utils/token_helper.dart';
import 'package:movies_app/features/home_screen/tabs/profile_tab/presentation/cubit/reset_password_cubite/reset_password_cubite.dart';
import 'package:movies_app/features/home_screen/tabs/profile_tab/presentation/cubit/reset_password_cubite/reset_password_state.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = getIt<ResetPasswordCubit>();

    Future<void> handleResetPassword() async {
      final oldPassword = cubit.oldPasswordController.text.trim();
      final newPassword = cubit.newPasswordController.text.trim();
      final token = await TokenHelper.getToken();

      if (token == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('You must be logged in first')),
        );
        return;
      }

      cubit.resetPassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
        token: token,
      );
    }

    return BlocProvider.value(
      value: cubit,
      child: BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
        listener: (context, state) {
          if (state is ResetPasswordSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
            Navigator.pop(context);
          } else if (state is ResetPasswordFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errMessage)));
          }
        },
        builder: (context, state) {
          final isLoading = state is ResetPasswordLoading;

          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.eerieBlack,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
              title: const Text(
                'Reset Password',
                style: TextStyle(
                  color: Colors.yellow,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(
                    AppImages.forgetPassWord,
                    height: 200,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 30),
                  CustomTextFiled(
                    icon: Icons.lock,
                    isPassword: true,
                    label: "Old Password",
                    validator: validatePassword,
                    controller: cubit.oldPasswordController,
                  ),
                  const SizedBox(height: 10),
                  CustomTextFiled(
                    icon: Icons.lock,
                    isPassword: true,
                    label: "New Password",
                    validator: validatePassword,
                    controller: cubit.newPasswordController,
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    onTap: handleResetPassword,
                    content: isLoading ? "Updating..." : "Update Password",
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
