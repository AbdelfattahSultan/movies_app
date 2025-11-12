import 'package:equatable/equatable.dart';
import 'package:movies_app/features/profile/data/models/user_model.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserModel user;
  const ProfileLoaded(this.user);

  @override
  List<Object?> get props => [user];
}

class ProfileUpdated extends ProfileState {
  final UserModel user;
  const ProfileUpdated(this.user);

  @override
  List<Object?> get props => [user];
}

class ProfileDeleted extends ProfileState {}

class ProfileError extends ProfileState {
  final String message;
  const ProfileError(this.message);

  @override
  List<Object?> get props => [message];
}
