import 'package:flutter/material.dart';
import 'package:movies_app/features/authentication/forget_password/api/api_service.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController codeController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool isLoading = false;

  Future<void> resetPassword() async {
    final code = codeController.text.trim();
    final newPassword = newPasswordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (code.isEmpty || newPassword.isEmpty || confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('من فضلك املأ جميع الحقول')),
      );
      return;
    }

    if (newPassword != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('كلمتا المرور غير متطابقتين')),
      );
      return;
    }

    setState(() => isLoading = true);

    // احفظ المراجع قبل await
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    final result = await ApiService.patchResetPassword(code, newPassword);

    if (!mounted) return; // تأكد أن الـwidget لسه موجودة بعد الـawait

    setState(() => isLoading = false);

    messenger.showSnackBar(
      SnackBar(
        content: Text(
          result ? 'تم تعيين كلمة المرور بنجاح ✅' : 'فشل في تعيين كلمة المرور ❌',
        ),
      ),
    );

    if (result) {
      navigator.pop(); // رجوع للشاشة السابقة
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('إعادة تعيين كلمة المرور')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: codeController,
              decoration: const InputDecoration(
                labelText: 'رمز التحقق',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: newPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'كلمة المرور الجديدة',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: confirmPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'تأكيد كلمة المرور',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: isLoading ? null : resetPassword,
              child: isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('تأكيد'),
            ),
          ],
        ),
      ),
    );
  }
}
