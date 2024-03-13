import '../../../../core/result/result.dart';
import '../entities/login_success.dart';
import '../entities/register_success.dart';

abstract interface class AuthRepository {
  Future<Result<RegisterSuccess>> registerWithEmailPassword({
    required String email,
    required String password,
  });
  Future<Result<LoginSuccess>> loginWithEmailPassword({
    required String email,
    required String password,
  });
  Future<Result<LoginSuccess>> currentUser();
}
