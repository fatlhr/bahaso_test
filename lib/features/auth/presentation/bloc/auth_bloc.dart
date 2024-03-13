import 'package:bahaso_test/core/result/result.dart';
import 'package:bahaso_test/features/auth/data/models/user_model.dart';
import 'package:bahaso_test/features/auth/domain/entities/login_success.dart';
import 'package:bahaso_test/features/auth/domain/entities/register_success.dart';
import 'package:bahaso_test/features/auth/domain/entities/user.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/cubits/app_user/app_user_cubit.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/usecases/current_user.dart';
import '../../domain/usecases/params/user_auth_params.dart';
import '../../domain/usecases/user_login.dart';
import '../../domain/usecases/user_register.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRegister _userRegister;
  final UserLogin _userLogin;
  final AppUserCubit _appUserCubit;
  final CurrentUser _currentUser;
  AuthBloc({
    required UserRegister userRegister,
    required UserLogin userLogin,
    required AppUserCubit appUserCubit,
    required CurrentUser currentUser,
  })  : _userRegister = userRegister,
        _userLogin = userLogin,
        _appUserCubit = appUserCubit,
        _currentUser = currentUser,
        super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<AuthLogin>(_onAuthLogin);
    on<AuthRegister>(_onAuthRegister);
    on<AuthIsUserLoggedIn>(_isUserLoggedIn);
  }
  void _onAuthRegister(
    AuthRegister event,
    Emitter<AuthState> emit,
  ) async {
    if (event.password.length < 6) {
      return emit(
        const AuthFailure('Password cannot be less than 6 characters!'),
      );
    }
    final res = await _userRegister(
      UserAuthParams(
        email: event.email,
        password: event.password,
      ),
    );
    return switch (res) {
      Success<RegisterSuccess>(value: final data) =>
        _emitRegisterSuccess(data, emit),
      Failed<RegisterSuccess>(message: final m) => emit(
          AuthFailure(m),
        ),
    };
  }

  void _onAuthLogin(
    AuthLogin event,
    Emitter<AuthState> emit,
  ) async {
    if (event.password.length < 6) {
      return emit(
        const AuthFailure('Password cannot be less than 6 characters!'),
      );
    } else if (event.email != "eve.holt@reqres.in") {
      return emit(
        const AuthFailure('Account not found!'),
      );
    }
    final res = await _userLogin(
      UserAuthParams(
        email: event.email,
        password: event.password,
      ),
    );
    return switch (res) {
      Success<LoginSuccess>(value: final data) => _emitLoginSuccess(data, emit),
      Failed<LoginSuccess>(message: final m) => emit(AuthFailure(m)),
    };
  }

  void _isUserLoggedIn(
    AuthIsUserLoggedIn event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _currentUser(NoParams());

    return switch (res) {
      Success<User>(value: final data) => _emitCurrentUser(data, emit),
      Failed<User>(message: final m) => emit(AuthFailure(m)),
    };
  }

  void _emitLoginSuccess(
    LoginSuccess user,
    Emitter<AuthState> emit,
  ) {
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user));
  }

  void _emitRegisterSuccess(
    RegisterSuccess user,
    Emitter<AuthState> emit,
  ) {
    // _appUserCubit.updateUser(user);
    emit(AuthSuccess(user));
  }

  void _emitCurrentUser(
    User user,
    Emitter<AuthState> emit,
  ) {
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user));
  }

  bool isEmailValid(String email, List<UserModel> userList) {
    // Mengecek apakah email ada dalam daftar email pengguna
    return userList.any((user) => user.email == email);
  }
}
