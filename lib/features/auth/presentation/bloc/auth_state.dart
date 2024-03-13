part of 'auth_bloc.dart';

@immutable
sealed class AuthState {
  const AuthState();
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess<T> extends AuthState {
  final LoginSuccess user;
  const AuthSuccess(this.user);
}


final class AuthFailure extends AuthState {
  final String message;
  const AuthFailure(this.message);
}
