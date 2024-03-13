import 'package:flutter/material.dart';

import '../../../../core/theme/app_pallete.dart';
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
            child: InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: () {},
              child: Container(
                height: size.height / 8,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppPallete.borderColor,
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 24.0,
                  backgroundColor: AppPallete.gradient1,
                  child: Text(data[index].questionnumber),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
