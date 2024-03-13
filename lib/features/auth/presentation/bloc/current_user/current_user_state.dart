part of 'current_user_bloc.dart';

@immutable
sealed class CurrentUserState {}

final class CurrentUserInitial extends CurrentUserState {}

final class CurrentUserLoading extends CurrentUserState {}

final class CurrentUserSuccess extends CurrentUserState {
  final User user;
  CurrentUserSuccess(this.user);
}

final class CurrentUserFailure extends CurrentUserState {
  final String message;
  CurrentUserFailure(this.message);
}
