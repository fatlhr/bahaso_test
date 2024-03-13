// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:bahaso_test/core/theme/app_pallete.dart';
import 'package:bahaso_test/features/auth/presentation/bloc/current_user/current_user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      body: BlocConsumer<CurrentUserBloc, CurrentUserState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is CurrentUserLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is CurrentUserSuccess) {
            return CustomScrollView(
              shrinkWrap: true,
              slivers: [
                SliverAppBar(
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
                  actions: const [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.more_vert),
                    ),
                  ],
                  title: ListTile(
                    title: Text(
                      state.user.firstName,
                    ),
                    subtitle: Text(state.user.email),
                  ),
                ),
              ],
            );
          }
          return const Center(
            child: Icon(
              Icons.error,
              size: 24.0,
            ),
          );
        },
      ),
    );
  }
}
