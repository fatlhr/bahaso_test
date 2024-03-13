import 'package:bahaso_test/core/result/result.dart';

import '../../../../core/usecase/usecase.dart';
import '../entities/login_success.dart';
import '../repository/auth_repository.dart';
import 'params/user_auth_params.dart';

class UserLogin implements UseCase<Result<LoginSuccess>, UserAuthParams> {
  final AuthRepository authRepository;
  const UserLogin(this.authRepository);

  @override
  Future<Result<LoginSuccess>> call(UserAuthParams params) async {
    return await authRepository.loginWithEmailPassword(
      email: params.email,
      password: params.password,
    );
  }
}
