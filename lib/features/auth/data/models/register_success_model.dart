import '../../domain/entities/register_success.dart';

class RegisterSuccessModel extends RegisterSuccess {
  RegisterSuccessModel({
    required super.id,
    required super.token,
  });

  factory RegisterSuccessModel.fromJson(Map<String, dynamic> map) {
    return RegisterSuccessModel(
      id: map['id'],
      token: map["token"],
    );
  }

  RegisterSuccessModel copyWith({
    String? id,
    String? token,
  }) {
    return RegisterSuccessModel(
      id: id ?? this.id,
      token: token ?? this.token,
    );
  }
}
