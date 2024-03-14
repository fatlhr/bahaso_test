import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/content/content_bloc.dart';
import 'audio_widget.dart';
import 'image_widget.dart';
import 'video_widget.dart';

class ContentItemWidget extends StatefulWidget {
  const ContentItemWidget({
    Key? key,
    required this.contentUrl,
  }) : super(key: key);
  final String contentUrl;

  @override
  State<ContentItemWidget> createState() => _ContentItemWidgetState();
}

class _ContentItemWidgetState extends State<ContentItemWidget> {
  @override
  void initState() {
    context.read<ContentBloc>().add(DetectContentTypeEvent(widget.contentUrl));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContentBloc, ContentState>(
      builder: (context, state) {
        if (state is ContentTypeLoaded) {
          return _buildContentWidget(
            contentType: state.contentType,
            contentUrl: widget.contentUrl,
          );
        }
        return const Text("load content...");
      },
    );
  }

  Widget _buildContentWidget({
    required String contentType,
    required String contentUrl,
  }) {
    switch (contentType) {
      case 'image':
        return ImageWidget(url: contentUrl);
      case 'audio':
        return AudioWidget(
          url: contentUrl,
        );
      case 'video':
        return const VideoWidget();
      default:
        return const Text('Unknown Content Type');
    }
  }
}
