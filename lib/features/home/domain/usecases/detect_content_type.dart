// domain/usecase/detect_content_type_usecase.dart

import '../repository/content_repository.dart';

class DetectContentTypeUsecase {
  final ContentRepository _repository;

  DetectContentTypeUsecase(this._repository);

  Future<String> call(String url) async {
    return await _repository.detectContentType(url);
  }
}
