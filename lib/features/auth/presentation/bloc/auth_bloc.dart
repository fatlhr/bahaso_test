import 'package:bahaso_test/core/result/result.dart';
import 'package:bahaso_test/features/auth/data/models/login_success_model.dart';
import 'package:bahaso_test/features/auth/data/models/register_success_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/cubits/app_user/app_user_cubit.dart';
import '../../domain/usecases/params/user_auth_params.dart';
import '../../domain/usecases/user_login.dart';
import '../../domain/usecases/user_register.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRegister _userRegister;
  final UserLogin _userLogin;
  final AppUserCubit _appUserCubit;
  AuthBloc({
    required UserRegister userRegister,
    required UserLogin userLogin,
    required AppUserCubit appUserCubit,
  })  : _userRegister = userRegister,
        _userLogin = userLogin,
        _appUserCubit = appUserCubit,
        super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<AuthRegister>(_onAuthRegister);
    on<AuthLogin>(_onAuthLogin);
  }
  void _onAuthRegister(
    AuthRegister event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _userRegister(
      UserAuthParams(
        email: event.email,
        password: event.password,
      ),
    );

    return switch (res) {
      Success<RegisterSuccessModel>(value: final data) =>
        _emitAuthSuccess(data, emit),
      Failed<RegisterSuccessModel>(message: final m) => emit(AuthFailure(m)),
    };
  }

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
      Success<LoginSuccessModel>(value: final data) =>
        _emitAuthSuccess(data, emit),
      Failed<LoginSuccessModel>(message: final m) => emit(AuthFailure(m)),
    };
  }

  void _emitAuthSuccess<T>(
    T user,
    Emitter<AuthState> emit,
  ) {
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user));
  }
}
