import 'package:bahaso_test/core/result/result.dart';
import 'package:bahaso_test/features/auth/data/models/login_success_model.dart';

import '../../../../core/usecase/usecase.dart';
import '../repository/auth_repository.dart';
import 'params/user_auth_params.dart';

class UserLogin implements UseCase<Result<LoginSuccessModel>, UserAuthParams> {
  final AuthRepository authRepository;
  const UserLogin(this.authRepository);

  @override
  Future<Result<LoginSuccessModel>> call(UserAuthParams params) async {
    return await authRepository.loginWithEmailPassword(
      email: params.email,
      password: params.password,
    );
  }
}
