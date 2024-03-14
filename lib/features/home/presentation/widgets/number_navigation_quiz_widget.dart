import 'package:bahaso_test/core/theme/app_pallete.dart';
import 'package:bahaso_test/features/home/presentation/bloc/question_page/question_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/question_datum_model.dart';

class NumberNavigationQuizWidget extends StatelessWidget {
  const NumberNavigationQuizWidget({
    super.key,
    required this.data,
    required this.quizPageController,
  });

  final List<QuestionDatumModel> data;
  final PageController quizPageController;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      height: size.height / 10,
      child: BlocBuilder<QuestionPageBloc, int>(
        builder: (context, state) {
          print('Builder function called. State: $state');
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 8.0,
                ),
                child: ClipOval(
                  child: ElevatedButton(
                    onPressed: state + 1 <= index
                        ? null
                        : () {
                            quizPageController.jumpToPage(index);
                          },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: state + 1 <= index
                          ? AppPallete.borderColor
                          : AppPallete.gradient1,
                      elevation: 5, // elevation
                      shape: const CircleBorder(),
                    ),
                    child: Text(
                      data[index].questionnumber,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
