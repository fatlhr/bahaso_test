import 'package:flutter/material.dart';

class QuestionWidget extends StatelessWidget {
  const QuestionWidget({
    super.key,
    required this.question,
  });
  final List<String> question;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: question.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (cnotext, index) {
        return Text(question[index]);
      },
    );
  }
}
