import 'package:bahaso_test/core/const/const.dart';
import 'package:bahaso_test/features/auth/data/models/login_success_model.dart';
import 'package:bahaso_test/features/auth/data/models/register_success_model.dart';
import 'package:dio/dio.dart';

abstract interface class AuthRemoteDataSource {
  Future<RegisterSuccessModel> registerWithEmailPassword({
    required String email,
    required String password,
  });
  Future<LoginSuccessModel> loginWithEmailPassword({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio _dio;

  AuthRemoteDataSourceImpl(Object object, {Dio? dio}) : _dio = dio ?? Dio();
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
    return RegisterSuccessModel.fromJson(response.data);
  }
}
