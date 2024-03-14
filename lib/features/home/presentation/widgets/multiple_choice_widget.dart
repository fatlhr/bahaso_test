import 'package:bahaso_test/features/home/data/models/choice_datum_model.dart';
import 'package:flutter/material.dart';

class MultipleChoiceWidget extends StatefulWidget {
  const MultipleChoiceWidget({
    Key? key,
    required this.options,
    required this.onSelected,
  }) : super(key: key);
  final List<ChoiceDatumModel> options;
  final Function(String) onSelected;
  @override
  State<MultipleChoiceWidget> createState() => _MultipleChoiceWidgetState();
}

class _MultipleChoiceWidgetState extends State<MultipleChoiceWidget> {
  String? _selectedOption;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Choose an option:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widget.options.map((option) {
            return RadioListTile(
              title: Text(option.text),
              value: option.value,
              groupValue: _selectedOption,
              onChanged: (value) {
                setState(() {
                  _selectedOption = value;
                  widget.onSelected(value as String);
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
