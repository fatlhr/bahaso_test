// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:bahaso_test/core/theme/app_pallete.dart';
import 'package:bahaso_test/features/auth/presentation/bloc/current_user/current_user_bloc.dart';
import 'package:bahaso_test/features/home/presentation/bloc/quiz_bloc/quiz_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/presentation/pages/login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static route() => MaterialPageRoute(builder: (context) => const HomePage());

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          BlocBuilder<CurrentUserBloc, CurrentUserState>(
            builder: (context, state) {
              if (state is CurrentUserLoading) {
                return const SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              if (state is CurrentUserSuccess) {
                return SliverAppBar(
                  backgroundColor: AppPallete.borderColor,
                  centerTitle: false,
                  leading: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                        state.user.avatar,
                      ),
                    ),
                  ),
                  actions: [
                    PopupMenuButton(
                      icon: const Icon(Icons.more_vert),
                      onSelected: (value) {
                        // your logic
                      },
                      itemBuilder: (BuildContext bc) {
                        return const [
                          PopupMenuItem(
                            value: '/logout',
                            child: Text("Logout"),
                          ),
                        ];
                      },
                    )
                  ],
                  title: ListTile(
                    title: Text(
                      state.user.firstName,
                    ),
                    subtitle: Text(state.user.email),
                  ),
                );
              }
              return const SliverToBoxAdapter(
                child: Center(
                  child: Icon(
                    Icons.error,
                    size: 24.0,
                  ),
                ),
              );
            },
          ),
          BlocConsumer<QuizBloc, QuizState>(
            listener: (context, state) {
              if (state is QuizFailure) {
                showSnackBar(
                  context,
                  Text(state.message),
                );
              }
            },
            builder: (context, state) {
              if (state is QuizLoading) {
                return const SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              return const SliverToBoxAdapter(
                child: Text("Quiz Loaded"),
              );
            },
          ),
        ],
      ),
    );
  }
}
