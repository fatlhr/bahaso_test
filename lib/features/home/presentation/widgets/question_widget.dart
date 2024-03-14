import 'package:flutter/material.dart';

import '../../../../core/utils.dart';
import 'content_item_widget.dart';

class QuestionWidget extends StatelessWidget {
  const QuestionWidget({super.key, required this.question});
  final List<String> question;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: question.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        if (isLink(question[index])) {
          return ContentItemWidget(contentUrl: question[index]);
        }
        return Text(question[index]);
      },
    );
  }
}
