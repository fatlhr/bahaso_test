import 'package:bahaso_test/features/home/presentation/bloc/quiz_bloc/quiz_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/common/cubits/app_user/app_user_cubit.dart';
import 'core/theme/theme.dart';
import 'features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'features/auth/presentation/bloc/current_user/current_user_bloc.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/home/presentation/bloc/content/content_bloc.dart';
import 'features/home/presentation/bloc/question_page/question_page_bloc.dart';
import 'features/home/presentation/pages/home_page.dart';
import 'init_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => serviceLocator<AppUserCubit>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<AuthBloc>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<CurrentUserBloc>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<QuizBloc>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<QuestionPageBloc>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<ContentBloc>(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthIsUserLoggedIn());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bahaso App',
      theme: AppTheme.darkThemeMode,
      // home: const LoginPage()
      home: BlocSelector<AppUserCubit, AppUserState, bool>(
        selector: (state) {
          return state is AppUserLoggedIn;
        },
        builder: (context, isLoggedIn) {
          if (isLoggedIn) {
            context.read<CurrentUserBloc>().add(CurrentUserLoggedIn());
            context.read<QuizBloc>().add(QuizLoaded());
            return const HomePage();
          }
          return const LoginPage();
        },
      ),
    );
  }
}
