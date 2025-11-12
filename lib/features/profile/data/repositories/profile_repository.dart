import 'package:dio/dio.dart';
import 'package:movies_app/core/config/constants.dart';
import 'package:movies_app/features/profile/data/models/user_model.dart';

class ProfileRepository {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: AppConstants.baseUrl,
      headers: {
        'Authorization': 'Bearer ${AppConstants.token}',
        'Content-Type': 'application/json',
      },
    ),
  );

  Future<UserModel> getProfile() async {
    try {
      final response = await _dio.get('/profile');
      final data = response.data['data'];
      if (data != null) {
        return UserModel.fromJson(data);
      } else {
        throw Exception('Profile data not found');
      }
    } catch (e) {
      throw Exception('Failed to load profile: $e');
    }
  }

  Future<UserModel> updateProfile(UserModel user) async {
    try {
      final response = await _dio.patch(
        '/profile',
        data: {
          "name": user.name,
          "phone": user.phone,
          "avaterId": user.avaterId,
        },
      );

      if (response.statusCode == 200) {
        return await getProfile();
      } else {
        throw Exception('Unexpected status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to update profile: $e');
    }
  }

  Future<void> deleteProfile() async {
    try {
      await _dio.delete('/profile');
    } catch (e) {
      throw Exception('Failed to delete profile: $e');
    }
  }
}
