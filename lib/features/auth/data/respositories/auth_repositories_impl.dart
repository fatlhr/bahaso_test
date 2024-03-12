import 'package:bahaso_test/core/result/result.dart';
import 'package:bahaso_test/features/auth/data/models/login_success_model.dart';
import 'package:bahaso_test/features/auth/data/models/register_success_model.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/connection_checker.dart';
import '../../domain/repository/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final ConnectionChecker connectionChecker;

  AuthRepositoryImpl(
    this.remoteDataSource,
    this.connectionChecker,
  );

  @override
  Future<Result<LoginSuccessModel>> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await remoteDataSource.loginWithEmailPassword(
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<Result<RegisterSuccessModel>> registerWithEmailPassword({
    required String email,
    required String password,
  }) {
    return _getUser(
      () async => await remoteDataSource.registerWithEmailPassword(
        email: email,
        password: password,
      ),
    );
  }

  Future<Result<T>> _getUser<T>(
    Future<T> Function() fn,
  ) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return const Result.failed("");
      }
      final user = await fn();

      return Result.success(user);
    } on ServerException catch (e) {
      return Result.failed(e.message);
    }
  }
}
