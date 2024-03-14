// domain/repository/content_repository.dart

abstract class ContentRepository {
  Future<String> detectContentType(String url);
}
