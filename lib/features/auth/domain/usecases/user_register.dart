import 'package:bahaso_test/core/result/result.dart';

import '../../../../core/usecase/usecase.dart';
import '../entities/register_success.dart';
import '../repository/auth_repository.dart';
import 'params/user_auth_params.dart';

class UserRegister implements UseCase<Result<RegisterSuccess>, UserAuthParams> {
  final AuthRepository authRepository;
  const UserRegister(this.authRepository);

  @override
  Future<Result<RegisterSuccess>> call(UserAuthParams params) async {
    return await authRepository.registerWithEmailPassword(
      email: params.email,
      password: params.password,
    );
  }
}
