import 'package:bahaso_test/core/const/const.dart';
import 'package:bahaso_test/features/auth/data/models/login_success_model.dart';
import 'package:bahaso_test/features/auth/data/models/register_success_model.dart';
import 'package:dio/dio.dart';

import '../../../../core/error/exceptions.dart';
import '../models/user_model.dart';

abstract interface class AuthRemoteDataSource {
  Future<RegisterSuccessModel> registerWithEmailPassword({
    required String email,
    required String password,
  });
  Future<LoginSuccessModel> loginWithEmailPassword({
    required String email,
    required String password,
  });
  Future<UserModel?> getCurrentUserData();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio _dio;

  AuthRemoteDataSourceImpl({Dio? dio}) : _dio = dio ?? Dio();
  @override
  Future<LoginSuccessModel> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    final response = await _dio.post(
      '${Const.reqresApi}/login',
      data: {
        "email": email,
        "password": password,
      },
    );
    return LoginSuccessModel.fromJson(response.data);
  }

  @override
  Future<RegisterSuccessModel> registerWithEmailPassword({
    required String email,
    required String password,
  }) async {
    final response = await _dio.post(
      '${Const.reqresApi}/register',
      data: {
        "email": email,
        "password": password,
      },
    );
    // print("register response: ${response.data}");
    return RegisterSuccessModel.fromJson(response.data);
  }

  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      final response = await _dio.get(
        '${Const.reqresApi}/users/4',
      );

      return UserModel.fromMap(response.data["data"]);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
