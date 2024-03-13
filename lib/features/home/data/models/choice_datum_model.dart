import 'dart:convert';

import '../../domain/entities/choice_datum.dart';

class ChoiceDatumModel extends ChoiceDatum {
  ChoiceDatumModel({
    required super.text,
    required super.name,
    required super.value,
  });
  factory ChoiceDatumModel.fromRawJson(String str) =>
      ChoiceDatumModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ChoiceDatumModel.fromJson(Map<String, dynamic> json) =>
      ChoiceDatumModel(
        text: json["text"],
        name: json["name"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "name": name,
        "value": value,
      };
}
