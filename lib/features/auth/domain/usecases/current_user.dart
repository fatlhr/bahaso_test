import 'package:bahaso_test/core/result/result.dart';
import 'package:bahaso_test/features/auth/domain/entities/login_success.dart';

import '../../../../core/usecase/usecase.dart';
import '../entities/user.dart';
import '../repository/auth_repository.dart';

class CurrentUser implements UseCase<Result<LoginSuccess>, NoParams> {
  final AuthRepository authRepository;
  CurrentUser(this.authRepository);

  @override
  Future<Result<LoginSuccess>> call(NoParams params) async {
    return await authRepository.currentUser();
  }
}
