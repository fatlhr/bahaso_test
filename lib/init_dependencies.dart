import 'package:bahaso_test/features/home/data/datasources/quiz_remote_datasource.dart';
import 'package:bahaso_test/features/home/domain/repository/quiz_repository.dart';
import 'package:bahaso_test/features/home/domain/usecases/get_quiz_usecase.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import 'core/common/cubits/app_user/app_user_cubit.dart';
import 'core/network/connection_checker.dart';
import 'features/auth/data/datasources/auth_remote_datasource.dart';
import 'features/auth/data/respositories/auth_repositories_impl.dart';
import 'features/auth/domain/repository/auth_repository.dart';
import 'features/auth/domain/usecases/current_user.dart';
import 'features/auth/domain/usecases/user_login.dart';
import 'features/auth/domain/usecases/user_register.dart';
import 'features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'features/auth/presentation/bloc/current_user/current_user_bloc.dart';
import 'features/home/data/respositories/quiz_repository_impl.dart';
import 'features/home/presentation/bloc/quiz_bloc/quiz_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initHome();

  // Dio
  serviceLocator.registerSingleton<Dio>(Dio());

  serviceLocator.registerFactory(() => InternetConnection());

  // core
  serviceLocator.registerLazySingleton(
    () => AppUserCubit(),
  );
  serviceLocator.registerFactory<ConnectionChecker>(
    () => ConnectionCheckerImpl(
      serviceLocator(),
    ),
  );
}

void _initAuth() {
  // Datasource
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        dio: serviceLocator(),
      ),
    )
    // Repository
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        serviceLocator(),
        serviceLocator(),
      ),
    )
    // Usecases
    ..registerFactory<UserRegister>(
      () => UserRegister(
        serviceLocator(),
      ),
    )
    ..registerFactory<UserLogin>(
      () => UserLogin(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => CurrentUser(
        serviceLocator(),
      ),
    );

  // Register AuthBloc
  serviceLocator.registerLazySingleton<AuthBloc>(
    () => AuthBloc(
      userRegister: serviceLocator(),
      userLogin: serviceLocator(),
      appUserCubit: serviceLocator(),
      currentUser: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<CurrentUserBloc>(
    () => CurrentUserBloc(currentUser: serviceLocator()),
  );
}

void _initHome() {
  // Datasource
  serviceLocator
    ..registerFactory<QuizRemoteDatasource>(
      () => QuizRemoteDatasourceImpl(
        dio: serviceLocator(),
      ),
    )
    // Repository
    ..registerFactory<QuizRepository>(
      () => QuizRepositoryImpl(
        serviceLocator(),
        serviceLocator(),
      ),
    )
    // Usecases
    ..registerFactory<GetQuizUseCase>(
      () => GetQuizUseCase(
        serviceLocator(),
      ),
    );

  // Register QuizBloc
  serviceLocator.registerLazySingleton<QuizBloc>(
    () => QuizBloc(
      getQuiz: serviceLocator(),
    ),
  );
}
