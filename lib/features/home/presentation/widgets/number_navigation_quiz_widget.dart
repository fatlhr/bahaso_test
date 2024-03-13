import 'package:bahaso_test/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

import '../../data/models/question_datum_model.dart';

class NumberNavigationQuizWidget extends StatelessWidget {
  const NumberNavigationQuizWidget({
    super.key,
    required this.data,
  });

  final List<QuestionDatumModel> data;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      height: size.height / 10,
      child: ListView.builder(
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
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: AppPallete.gradient1, // text color
                  elevation: 5, // elevation
                  shape: const CircleBorder(), // circular shape
                ),
                child: Text(data[index].questionnumber),
              ),
            ),
          );
        },
      ),
    );
  }
}
