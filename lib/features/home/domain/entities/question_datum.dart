import '../../data/models/choice_datum_model.dart';

class QuestionDatum {
  final List<String> question;
  final int questionnumber;
  final String typequestion;
  final String name;
  final String value;
  final int grade;
  final List<ChoiceDatumModel> data;

  QuestionDatum({
    required this.question,
    required this.questionnumber,
    required this.typequestion,
    required this.name,
    required this.value,
    required this.grade,
    required this.data,
  });
}
