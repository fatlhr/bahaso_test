import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/content/content_bloc.dart';
import 'audio_widget.dart';
import 'image_widget.dart';
import 'video_widget.dart';

class ContentItemWidget extends StatefulWidget {
  const ContentItemWidget({
    Key? key,
    required this.contentType,
  }) : super(key: key);
  final String contentType;

  @override
  State<ContentItemWidget> createState() => _ContentItemWidgetState();
}

class _ContentItemWidgetState extends State<ContentItemWidget> {
  @override
  void initState() {
    context.read<ContentBloc>().add(DetectContentTypeEvent(widget.contentType));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContentBloc, ContentState>(
      builder: (context, state) {
        if (state is ContentTypeLoaded) {
          print("state.contentType: ${state.contentType}");
          return _buildContentWidget(state.contentType);
        }
        return const Text("load content...");
      },
    );
  }

  Widget _buildContentWidget(String contentType) {
    print("build content type: $contentType");
    switch (contentType) {
      case 'image':
        return const ImageWidget();
      case 'audio':
        return const AudioWidget();
      case 'video':
        return const VideoWidget();
      default:
        return const Text('Unknown Content Type');
    }
  }
}
