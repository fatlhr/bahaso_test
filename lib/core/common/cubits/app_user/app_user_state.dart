part of 'app_user_cubit.dart';

@immutable
sealed class AppUserState {}

final class AppUserInitial extends AppUserState {}

final class AppUserLoggedIn<T> extends AppUserState {
  final T user;
  AppUserLoggedIn(this.user);
}
