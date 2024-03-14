// data/repository/content_repository_impl.dart

import 'package:dio/dio.dart';

import '../../../../core/enum/enum.dart';
import '../../domain/repository/content_repository.dart';

class ContentRepositoryImpl implements ContentRepository {
  @override
  Future<String> detectContentType(String url) async {
    try {
      final response = await Dio().head(url);
      final contentType = response.headers.map['content-type']?.first;

      if (contentType != null) {
        // print("contentType: ${contentType.split('/')[0]}");
        // print("imge name: ${ContentType.image.name}");
        if (contentType.split('/')[0] == ContentType.image.name) {
          return ContentType.image.name;
        } else if (contentType.split('/')[0] == ContentType.audio.name) {
          return ContentType.audio.name;
        } else if (contentType.split('/')[0] == ContentType.video.name) {
          return ContentType.video.name;
        } else {
          return ContentType.unknown.name;
        }
      } else {
        return ContentType.unknown.name;
      }
    } catch (e) {
      return ContentType.unknown.name;
    }
  }
}
