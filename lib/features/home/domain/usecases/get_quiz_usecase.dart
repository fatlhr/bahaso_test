import 'package:bahaso_test/core/usecase/usecase.dart';
import 'package:bahaso_test/features/home/data/models/quiz_model.dart';
import 'package:bahaso_test/features/home/domain/repository/quiz_repository.dart';

import '../../../../core/result/result.dart';

class GetQuizUseCase implements UseCase<Result<QuizModel>, NoParams> {
  final QuizRepository quizRepository;
  GetQuizUseCase(this.quizRepository);

  @override
  Future<Result<QuizModel>> call(NoParams params) async {
    return await quizRepository.getQuizRepository();
  }
}
