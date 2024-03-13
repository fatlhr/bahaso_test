import 'package:bahaso_test/core/result/result.dart';
import 'package:bahaso_test/features/auth/domain/entities/login_success.dart';
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
  ) async {}

  void _onAuthLogin(
    AuthLogin event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _userLogin(
      UserAuthParams(
        email: event.email,
        password: event.password,
      ),
    );

    return switch (res) {
      Success<LoginSuccess>(value: final data) => _emitAuthSuccess(data, emit),
      Failed<LoginSuccess>(message: final m) => emit(AuthFailure(m)),
    };
  }

  void _isUserLoggedIn(
    AuthIsUserLoggedIn event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _currentUser(NoParams());

    return switch (res) {
      Success<LoginSuccess>(value: final data) => _emitAuthSuccess(data, emit),
      Failed<LoginSuccess>(message: final m) => emit(AuthFailure(m)),
    };
  }

  void _emitAuthSuccess(
    LoginSuccess user,
    Emitter<AuthState> emit,
  ) {
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user));
  }
}
