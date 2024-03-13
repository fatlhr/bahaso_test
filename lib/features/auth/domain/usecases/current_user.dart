import 'package:bahaso_test/core/result/result.dart';

import '../../../../core/usecase/usecase.dart';
import '../entities/user.dart';
import '../repository/auth_repository.dart';

class CurrentUser implements UseCase<Result<User>, NoParams> {
  final AuthRepository authRepository;
  CurrentUser(this.authRepository);

  @override
  Future<Result<User>> call(NoParams params) async {
    return await authRepository.currentUser();
  }
}
