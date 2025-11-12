import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/common_widgets/validator.dart';
import 'package:movies_app/core/common_widgets/custom_button.dart';
import 'package:movies_app/core/common_widgets/custom_text_filed.dart';
import 'package:movies_app/features/authentication/presentation/auth_cubite/lang/language_switch.dart';
import 'package:movies_app/core/config/app_colors.dart';
import 'package:movies_app/core/config/app_images.dart';
import 'package:movies_app/core/config/app_routes.dart';
import 'package:movies_app/features/authentication/data/auth_data_source/auth_data_source_imp.dart';
import 'package:movies_app/features/authentication/domain/auth_%20repository/auth_%20repository_impl.dart';
import 'package:movies_app/features/authentication/presentation/auth_cubite/login_cubit/login_cubit.dart';
import 'package:movies_app/features/authentication/presentation/auth_cubite/login_cubit/login_state.dart';
import 'package:movies_app/features/authentication/presentation/screen/Login/LoginGoogle.dart';
import 'package:movies_app/features/authentication/presentation/screen/Login/Or_Line.dart';
import 'package:movies_app/l10n/app_localizations.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool checkValidate() {
    return _formKey.currentState?.validate() ?? false;
  }

  @override
  Widget build(BuildContext context) {
    var l10n = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (context) => LoginCubit(
        AuthRepositoryImpl(authDataSource: AuthDataSourceImp(dio: Dio())),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocConsumer<LoginCubit, LoginState>(
          listener: (BuildContext context, state) {
            if (state is LoginSuccessState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Login Successful. Welcome!")),
              );
              Navigator.pushReplacementNamed(context, AppRoutes.registerScreen);
            } else if (state is LoginFailureState) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.errMessage)));
            }
          },
          builder: (BuildContext context, state) {
            return SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 40),
                    Column(children: [Image.asset(AppImages.logo, width: 152)]),
                    const SizedBox(height: 30),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          CustomTextFiled(
                            controller: emailController,
                            icon: Icons.email,
                            label: l10n.email,
                            validator: emailValidator,
                          ),
                          CustomTextFiled(
                            controller: passwordController,
                            icon: Icons.lock,
                            label: l10n.password,
                            isPassword: true,
                            validator: validatePassword,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.forgetPassword,
                            );
                          },
                          child: Text(
                            l10n.forgetPass,
                            style: TextStyle(color: AppColors.primary),
                          ),
                        ),
                      ],
                    ),
                    (state is LoginLoadingState)
                        ? const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    )
                        : CustomButton(
                            onTap: () {
                              if (checkValidate()) {
                                context.read<LoginCubit>().login(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                                Navigator.pushReplacementNamed(
                                  context,
                                  AppRoutes.homeScreen,
                                );
                              }
                            },
                            content: l10n.login,
                          ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          l10n.noAccount,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                              context,
                              AppRoutes.registerScreen,
                            );
                          },
                          child: Text(
                            l10n.createAccount,
                            style: TextStyle(color: AppColors.primary),
                          ),
                        ),
                      ],
                    ),
                    const OrLine(),
                    const Logingoogle(),
                    const SizedBox(height: 20),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [LanguageSwitch()],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}