import 'package:bahaso_test/features/home/data/models/quiz_model.dart';

import '../../../../core/result/result.dart';

abstract interface class QuizRepository {
  Future<Result<QuizModel>> getQuizRepository();
}
