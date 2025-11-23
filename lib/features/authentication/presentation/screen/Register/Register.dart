import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/common_widgets/Custom_Text_Filed.dart';
import 'package:movies_app/core/common_widgets/Validator.dart';
import 'package:movies_app/core/common_widgets/custom_button.dart';
import 'package:movies_app/core/config/app_colors.dart';
import 'package:movies_app/core/config/app_images.dart';
import 'package:movies_app/core/config/app_routes.dart';
import 'package:movies_app/features/authentication/data/auth_data_source/auth_data_source_imp.dart';
import 'package:movies_app/features/authentication/domain/auth_%20repository/auth_%20repository_impl.dart';
import 'package:movies_app/features/authentication/presentation/auth_cubite/register_cubit/register_cubit.dart';
import 'package:movies_app/features/authentication/presentation/auth_cubite/register_cubit/register_state.dart';
import 'package:movies_app/features/authentication/presentation/auth_cubite/lang/language_switch.dart';
import 'package:movies_app/l10n/app_localizations.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late final TextEditingController nameController;
  late final TextEditingController phoneController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;

  final _formKey = GlobalKey<FormState>();

  late PageController _pageController;
  double currentPage = 0;

  final List<String> avatars = [
    AppImages.avatar1,
    AppImages.avatar2,
    AppImages.avatar3,
    AppImages.avatar4,
    AppImages.avatar5,
    AppImages.avatar6,
    AppImages.avatar7,
    AppImages.avatar8,
    AppImages.avatar9,
  ];

  @override
  void initState() {
    nameController = TextEditingController();
    phoneController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();

    _pageController = PageController(viewportFraction: 0.5, initialPage: 2);
    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page ?? 0;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var l10n = AppLocalizations.of(context)!;
    return SafeArea(
      child: BlocProvider(
        create: (context) => RegisterCubit(
          AuthRepositoryImpl(authDataSource: AuthDataSourceImp(dio: Dio())),
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: BlocConsumer<RegisterCubit, RegisterState>(
            listener: (BuildContext context, RegisterState state) {
              if (state is RegisterSuccessState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Account created successfully "),
                  ),
                );
                Navigator.pushNamed(context, AppRoutes.loginScreen);
              } else if (state is RegisterFailureState) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.errMessage)));
              }
            },
            builder: (BuildContext context, RegisterState state) {
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 150,
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: avatars.length,
                        itemBuilder: (context, index) {
                          double distance = (currentPage - index).abs();
                          double scale;
                          if (distance < 1) {
                            scale = 1 - (distance * 0.15);
                          } else {
                            scale = 0.70;
                          }
                          return Transform.scale(
                            scale: scale,
                            child: Image.asset(
                              avatars[index],
                              width: 150,
                              height: 150,
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      l10n.chooseAvatar,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CustomTextFiled(
                            controller: nameController,
                            icon: Icons.person,
                            label: l10n.name,
                            validator: nameValidator,
                          ),
                          CustomTextFiled(
                            controller: emailController,
                            icon: Icons.email,
                            label: l10n.email,
                            validator: emailValidator,
                          ),
                          CustomTextFiled(
                            controller: phoneController,
                            icon: Icons.phone,
                            label: l10n.phone,
                            validator: phoneValidator,
                          ),
                          CustomTextFiled(
                            controller: passwordController,
                            icon: Icons.lock,
                            label: l10n.password,
                            isPassword: true,
                            validator: validatePassword,
                          ),
                          CustomTextFiled(
                            controller: confirmPasswordController,
                            icon: Icons.lock,
                            label: l10n.confirmPassword,
                            isPassword: true,
                            validator: (password) {
                              if (password == null || password.isEmpty) {
                                return 'Please re-enter password';
                              } else if (password != passwordController.text) {
                                return "Passwords do not match";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          (state is RegisterLoadingState)
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.primary,
                                  ),
                                )
                              : CustomButton(
                                  onTap: () {
                                    if (_formKey.currentState?.validate() ??
                                        false) {
                                      final avatarId =
                                          (_pageController.page?.round() ?? 0) +
                                          1;
                                      context.read<RegisterCubit>().register(
                                        name: nameController.text,
                                        email: emailController.text,
                                        password: passwordController.text,
                                        phone: phoneController.text,
                                        avatarId: avatarId,
                                      );
                                    }
                                  },
                                  content: l10n.createAccount,
                                ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                l10n.alreadyHave,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppRoutes.loginScreen,
                                  );
                                },
                                child: Text(
                                  l10n.login,
                                  style: TextStyle(color: AppColors.primary),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 10),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [LanguageSwitch()],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
