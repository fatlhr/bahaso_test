import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/question_datum_model.dart';
import '../bloc/multiple_choice/multiple_choice_bloc.dart';

class MultipleChoiceWidget extends StatefulWidget {
  const MultipleChoiceWidget({
    Key? key,
    required this.data,
    required this.page,
  }) : super(key: key);
  final QuestionDatumModel data;
  final int page;
  @override
  State<MultipleChoiceWidget> createState() => _MultipleChoiceWidgetState();
}

class _MultipleChoiceWidgetState extends State<MultipleChoiceWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final multipleChoiceBloc = BlocProvider.of<MultipleChoiceBloc>(context);
    final options = widget.data.data;
    return BlocBuilder<MultipleChoiceBloc, List<String>>(
      builder: (context, state) {
        return Column(
          children: [
            // Text(state.toString()),
            ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: options.length,
              itemBuilder: (context, index) {
                return RadioListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(options[index].text),
                  value: options[index].value,
                  groupValue: state[widget.page],
                  onChanged: (val) {
                    multipleChoiceBloc.add(
                      OptionSelected(
                        data: options.map((e) => e.value).toList(),
                        selectedOption: val!,
                        index: widget.page,
                      ),
                    );
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }
}
