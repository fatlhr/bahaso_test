import 'package:flutter/material.dart';

import '../../../../core/utils.dart';
import 'content_item_widget.dart';

// class QuestionWidget extends StatelessWidget {
//   const QuestionWidget({
//     super.key,
//     required this.question,
//   });
//   final List<String> question;

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ContentBloc, ContentState>(
//       builder: (context, state) {
//         return ListView.builder(
//           itemCount: question.length,
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           itemBuilder: (context, index) {
//             if (isLink(question[index])) {
//               if (state is ContentTypeLoaded) {
//                 return _buildContentWidget(state.contentType);
//               }
//               return const Text("ini link");
//             }
//             return Text(question[index]);
//           },
//         );
//       },
//     );
//   }

//   Widget _buildContentWidget(String contentType) {
//     switch (contentType) {
//       case 'image':
//         return const ImageWidget();
//       case 'audio':
//         return const AudioWidget();
//       case 'video':
//         return const VideoWidget();
//       default:
//         return const Text('Unknown Content Type');
//     }
//   }
// }

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
          return ContentItemWidget(contentType: question[index]);
        }
        return Text(question[index]);
      },
    );
  }
}



