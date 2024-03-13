import 'package:bahaso_test/features/home/data/models/quiz_model.dart';
import 'package:dio/dio.dart';

import '../../../../core/const/const.dart';

abstract interface class QuizRemoteDatasource {
  Future<QuizModel> getQuiz();
}

class QuizRemoteDatasourceImpl implements QuizRemoteDatasource {
  final Dio _dio;

  QuizRemoteDatasourceImpl({Dio? dio}) : _dio = dio ?? Dio();
  @override
  Future<QuizModel> getQuiz() async {
    final response = await _dio.get(
      '${Const.bahasoApi}/quiz/attempt-data-general-english-example',
    );
    return QuizModel.fromJson(response.data);
  }
}
