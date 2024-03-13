part of 'current_user_bloc.dart';

@immutable
sealed class CurrentUserEvent {}

final class CurrentUserLoggedIn extends CurrentUserEvent {}
