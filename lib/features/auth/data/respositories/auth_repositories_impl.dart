import 'package:bahaso_test/core/result/result.dart';
import 'package:bahaso_test/features/auth/domain/entities/login_success.dart';
import 'package:bahaso_test/features/auth/domain/entities/register_success.dart';

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
  Future<Result<LoginSuccess>> loginWithEmailPassword({
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
  Future<Result<RegisterSuccess>> registerWithEmailPassword({
    required String email,
    required String password,
  }) {
    return _createUser(
      () async => await remoteDataSource.registerWithEmailPassword(
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<Result<LoginSuccess>> currentUser() async {
    try {
      if (!await (connectionChecker.isConnected)) {
        // final session = remoteDataSource.currentUserSession;

        // if (session == null) {
        //   return const Result.failed('User not logged in!');
        // }

        return Result.success(LoginSuccess(token: ''));
      }
      // final user = await remoteDataSource.getCurrentUserData();
      // if (user == null) {
      //   return const Result.failed('User not logged in!');
      // }

      return Result.success(LoginSuccess(token: ''));
    } on ServerException catch (e) {
      return Result.failed(e.message);
    }
  }

  Future<Result<LoginSuccess>> _getUser(
    Future<LoginSuccess> Function() fn,
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

  Future<Result<RegisterSuccess>> _createUser(
    Future<RegisterSuccess> Function() fn,
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
