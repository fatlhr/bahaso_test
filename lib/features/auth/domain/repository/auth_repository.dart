import 'package:bahaso_test/features/auth/data/models/login_success_model.dart';
import 'package:bahaso_test/features/auth/data/models/register_success_model.dart';

import '../../../../core/result.dart';

abstract interface class AuthRepository {
  Future<Result<RegisterSuccessModel>> registerWithEmailPassword({
    required String email,
    required String password,
  });
  Future<Result<LoginSuccessModel>> loginWithEmailPassword({
    required String email,
    required String password,
  });
  // Future<Result<LoginSuccessModel>> currentUser();
}
