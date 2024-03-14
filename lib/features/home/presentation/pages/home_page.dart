// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:bahaso_test/core/enum/enum.dart';
import 'package:bahaso_test/features/home/presentation/bloc/question_page/question_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_pallete.dart';
import '../../../auth/presentation/bloc/current_user/current_user_bloc.dart';
import '../../../auth/presentation/pages/login_page.dart';
import '../bloc/quiz_bloc/quiz_bloc.dart';
import '../widgets/multiple_choice_widget.dart';
import '../widgets/number_navigation_quiz_widget.dart';
import '../widgets/question_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static route() => MaterialPageRoute(builder: (context) => const HomePage());

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final questionPageBloc = BlocProvider.of<QuestionPageBloc>(context);
    return Scaffold(
      body: CustomScrollView(
        shrinkWrap: true,
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
              if (state is QuizSuccess) {
                final data = state.data.data;
                return SliverFillRemaining(
                  child: Column(
                    children: [
                      Expanded(
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: data.length,
                          onPageChanged: (int page) {
                            questionPageBloc
                                .add(QuestionPageUpdated(pageIndex: page));
                          },
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              decoration: const BoxDecoration(
                                color: AppPallete.borderColor,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30.0),
                                ),
                              ),
                              margin: const EdgeInsets.all(16.0),
                              padding: const EdgeInsets.all(16.0),
                              child: ListView(
                                children: [
                                  QuestionWidget(
                                    question: data[index].question,
                                  ),
                                  const SizedBox(height: 16),
                                  data[index].typequestion ==
                                          TypeQuestion.multichoice.name
                                      ? MultipleChoiceWidget(
                                          options: data[index].data,
                                          onSelected: (value) {},
                                        )
                                      : const SizedBox.shrink()
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      NumberNavigationQuizWidget(
                        data: data,
                        quizPageController: _pageController,
                      ),
                      const SizedBox(height: 16.0),
                    ],
                  ),
                );
              }
              return const SliverToBoxAdapter(
                child: Center(
                  child: Text("Error!"),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
