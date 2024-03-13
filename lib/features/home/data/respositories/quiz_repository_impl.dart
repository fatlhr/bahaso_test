import 'package:bahaso_test/core/result/result.dart';
import 'package:bahaso_test/features/home/data/datasources/quiz_remote_datasource.dart';
import 'package:bahaso_test/features/home/data/models/quiz_model.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/connection_checker.dart';
import '../../domain/repository/quiz_repository.dart';

class QuizRepositoryImpl implements QuizRepository {
  final QuizRemoteDatasource remoteDataSource;
  final ConnectionChecker connectionChecker;

  QuizRepositoryImpl(
    this.remoteDataSource,
    this.connectionChecker,
  );
  @override
  Future<Result<QuizModel>> getQuizRepository() async {
    return _getData(
      () async => await remoteDataSource.getQuiz(),
    );
  }

  Future<Result<QuizModel>> _getData(
    Future<QuizModel> Function() fn,
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
