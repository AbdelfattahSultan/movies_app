abstract class RestDataSource {
  Future<bool> resetPassword({
    required String oldPassword,
    required String newPassword,
    required String token,
  });
}
