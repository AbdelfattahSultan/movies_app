import 'package:injectable/injectable.dart';
import 'package:movies_app/features/home_screen/tabs/profile_tab/rest_data/rest_data_source.dart';
import 'reset_password_repo.dart';


@LazySingleton(as: ResetPasswordRepo)
class ResetPasswordRepoImpl implements ResetPasswordRepo {
  final RestDataSource dataSource;

  ResetPasswordRepoImpl({required this.dataSource});

  @override
  Future<bool> resetPassword({
    required String oldPassword,
    required String newPassword,
    required String token,
  }) async {
    return await dataSource.resetPassword(
      oldPassword: oldPassword,
      newPassword: newPassword,
      token: token,
    );
  }
}
