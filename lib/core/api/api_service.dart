import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_constants.dart';

class ApiService {
  // -------------------------------
  // 1️⃣ إرسال الإيميل (Forget Password)
  // -------------------------------
  static Future<bool> resetPassword(String email) async {
    final url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.forgetPassword}');

    final response = await http.post(
      url,
      body: {'email': email},
    );

    if (response.statusCode == 200) {
      print('✅ تم إرسال رابط إعادة التعيين بنجاح');
      return true;
    } else {
      print('❌ فشل إرسال رابط إعادة التعيين: ${response.statusCode}');
      return false;
    }
  }

  // -------------------------------
  // 2️⃣ إعادة تعيين الباسورد (Reset Password)
  // -------------------------------
  static Future<bool> patchResetPassword(String oldPassword, String newPassword) async {
    final url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.resetPassword}');

    try {
      final response = await http.patch(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...' // حط هنا التوكن بتاعك
        },
        body: jsonEncode({
          'oldPassword': oldPassword,
          'newPassword': newPassword,
        }),
      );

      print('🔹 Status Code: ${response.statusCode}');
      print('🔹 Response: ${response.body}');

      if (response.statusCode == 201) {
        print('✅ تم تعيين كلمة المرور الجديدة بنجاح');
        return true;
      } else {
        print('❌ فشل في تعيين كلمة المرور: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('⚠️ خطأ أثناء الاتصال بالسيرفر: $e');
      return false;
    }
  }
}
