import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/profile/data/models/user_model.dart';
import 'package:movies_app/features/profile/data/repositories/profile_repository.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository profileRepository;
  ProfileCubit(this.profileRepository) : super(ProfileInitial());

  Future<void> getProfile() async {
    emit(ProfileLoading());
    try {
      final user = await profileRepository.getProfile();
      emit(ProfileLoaded(user));
    } catch (e) {
      emit(ProfileError('Failed to load profile: $e'));
    }
  }

  Future<void> updateProfile(UserModel updatedUser) async {
    emit(ProfileLoading());
    try {
      final newUser = await profileRepository.updateProfile(updatedUser);
      emit(ProfileUpdated(newUser));
    } catch (e) {
      emit(ProfileError('Failed to update profile: $e'));
    }
  }

  Future<void> deleteAccount() async {
    emit(ProfileLoading());
    try {
      await profileRepository.deleteProfile();
      emit(ProfileDeleted());
    } catch (e) {
      emit(ProfileError('Failed to delete profile: $e'));
    }
  }
}
