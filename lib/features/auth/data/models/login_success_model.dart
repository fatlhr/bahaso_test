import 'package:bahaso_test/features/auth/domain/entities/login_success.dart';

class LoginSuccessModel extends LoginSuccess {
  LoginSuccessModel({required super.token});

  factory LoginSuccessModel.fromJson(Map<String, dynamic> map) {
    return LoginSuccessModel(
      token: map["token"],
    );
  }

  LoginSuccessModel copyWith({
    String? token,
  }) {
    return LoginSuccessModel(
      token: token ?? this.token,
    );
  }
}
