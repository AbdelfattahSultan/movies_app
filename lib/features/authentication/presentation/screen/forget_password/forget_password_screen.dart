import 'package:flutter/material.dart';
import 'package:movies_app/core/common_widgets/Validator.dart';
import 'package:movies_app/core/common_widgets/custom_button.dart';
import 'package:movies_app/core/common_widgets/custom_text_filed.dart';
import 'package:movies_app/core/config/app_images.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Forget Password',
          style: TextStyle(color: Colors.yellow, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 20),
          Image.asset(AppImages.forgetPassWord, width: double.infinity),

          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: CustomTextFiled(
              icon: Icons.email,
              label: "email",
              validator: emailValidator,
              controller: emailController,
            ),
          ),
          const SizedBox(height: 16),
          CustomButton(onTap: () {}, content: "Verify Email"),
        ],
      ),
    );
  }
}
