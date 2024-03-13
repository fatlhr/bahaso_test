import 'dart:convert';

import 'package:bahaso_test/features/home/data/models/question_datum_model.dart';

class QuizModel {
  final int code;
  final String status;
  final String message;
  final List<QuestionDatumModel> data;

  QuizModel({
    required this.code,
    required this.status,
    required this.message,
    required this.data,
  });

  factory QuizModel.fromRawJson(String str) =>
      QuizModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory QuizModel.fromJson(Map<String, dynamic> json) => QuizModel(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        data: List<QuestionDatumModel>.from(
            json["data"].map((x) => QuestionDatumModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}
