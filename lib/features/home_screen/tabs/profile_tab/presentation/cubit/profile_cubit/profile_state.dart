import 'package:equatable/equatable.dart';
import 'package:movies_app/features/home_screen/tabs/profile_tab/data/models/user_model.dart';
import 'package:movies_app/features/home_screen/tabs/HomeTab/domain/model/movie.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserModel user;
  final List<Movie> favorites;

  const ProfileLoaded(this.user, this.favorites);

  @override
  List<Object?> get props => [user, favorites];
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
