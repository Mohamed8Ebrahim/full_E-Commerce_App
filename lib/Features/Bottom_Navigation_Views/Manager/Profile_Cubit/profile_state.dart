part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileSuccess extends ProfileState {
  final ProfileModel dataModel;

  ProfileSuccess(this.dataModel);
}

final class ProfileFailure extends ProfileState {
  final String errorMessage;

  ProfileFailure(this.errorMessage);
}

// LogOut
final class LogOutLoading extends ProfileState {}

final class LogOutSuccess extends ProfileState {
  final String message;

  LogOutSuccess(this.message);
}

final class LogOutFailure extends ProfileState {
  final String errorMessage;

  LogOutFailure(this.errorMessage);
}

// update profile
final class UpdateProfileLoading extends ProfileState {}

final class UpdateProfileSuccess extends ProfileState {
  final String message;

  UpdateProfileSuccess(this.message);
}

final class UpdateProfileFailure extends ProfileState {
  final String errorMessage;

  UpdateProfileFailure(this.errorMessage);
}

// change password
final class ChangePasswordLoading extends ProfileState {}

final class ChangePasswordSuccess extends ProfileState {
  final String message;

  ChangePasswordSuccess(this.message);
}

final class ChangePasswordFailure extends ProfileState {
  final String errorMessage;

  ChangePasswordFailure(this.errorMessage);
}
