import 'dart:convert';

import 'package:bahaso_test/features/home/domain/entities/question_datum.dart';

import 'choice_datum_model.dart';

class QuestionDatumModel extends QuestionDatum {
  QuestionDatumModel({
    required super.question,
    required super.questionnumber,
    required super.typequestion,
    required super.name,
    required super.value,
    required super.grade,
    required super.data,
  });
  factory QuestionDatumModel.fromRawJson(String str) =>
      QuestionDatumModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory QuestionDatumModel.fromJson(Map<String, dynamic> json) =>
      QuestionDatumModel(
        question: List<String>.from(json["question"].map((x) => x)),
        questionnumber: json["questionnumber"],
        typequestion: json["typequestion"],
        name: json["name"],
        value: json["value"],
        grade: json["grade"],
        data: List<ChoiceDatumModel>.from(
            json["data"].map((x) => ChoiceDatumModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "question": List<String>.from(question.map((x) => x)),
        "questionnumber": questionnumber,
        "typequestion": typequestion,
        "name": name,
        "value": value,
        "grade": grade,
        "data": List<ChoiceDatumModel>.from(data.map((x) => x.toJson())),
      };
}
