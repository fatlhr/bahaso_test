import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/result/result.dart';
import '../../../../../core/usecase/usecase.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/usecases/current_user.dart';

part 'current_user_event.dart';
part 'current_user_state.dart';

class CurrentUserBloc extends Bloc<CurrentUserEvent, CurrentUserState> {
  final CurrentUser _currentUser;
  CurrentUserBloc({
    required CurrentUser currentUser,
  })  : _currentUser = currentUser,
        super(CurrentUserInitial()) {
    on<CurrentUserLoggedIn>(_isUserLoggedIn);
  }
  void _isUserLoggedIn(
    CurrentUserLoggedIn event,
    Emitter<CurrentUserState> emit,
  ) async {
    final res = await _currentUser(NoParams());
    print("res isUserLoggedIn: $res");
    return switch (res) {
      Success<User>(value: final data) => _emitCurrentUser(data, emit),
      // Failed<User>(message: final _) => emit(CurrentUserInitial()),
      Failed<User>(message: final m) => emit(CurrentUserFailure(m)),
    };
  }

  void _emitCurrentUser(
    User user,
    Emitter<CurrentUserState> emit,
  ) {
    // _appUserCubit.updateUser(user);
    emit(CurrentUserSuccess(user));
  }
}
