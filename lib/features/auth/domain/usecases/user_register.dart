import 'package:bahaso_test/core/result/result.dart';
import 'package:bahaso_test/features/auth/data/models/register_success_model.dart';

import '../../../../core/usecase/usecase.dart';
import '../repository/auth_repository.dart';
import 'params/user_auth_params.dart';

class UserRegister
    implements UseCase<Result<RegisterSuccessModel>, UserAuthParams> {
  final AuthRepository authRepository;
  const UserRegister(this.authRepository);

  @override
  Future<Result<RegisterSuccessModel>> call(UserAuthParams params) async {
    return await authRepository.registerWithEmailPassword(
      email: params.email,
      password: params.password,
    );
  }
}
