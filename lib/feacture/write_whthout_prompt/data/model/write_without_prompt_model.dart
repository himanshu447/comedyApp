import 'package:equatable/equatable.dart';

class WriteWithoutPromptModel extends Equatable {
  final int id;
  final String title;
  final String description;
  final List<String> tags;
  final int levelOfCompleteness;
  final int degreeOfSucking;

  WriteWithoutPromptModel({
    this.id,
    this.title,
    this.description,
    this.tags,
    this.levelOfCompleteness,
    this.degreeOfSucking,
  });

  factory WriteWithoutPromptModel.fromMap(Map<String, dynamic> json) =>
      WriteWithoutPromptModel(
        id: json['id'] != null ? json['id'] : null,
        title: json["title"] != null ? json["title"] : null,
        description: json["description"] != null ? json["description"] : null,
        tags: json["tags"] != null
            ? (json["tags"] as List<String>).map((e) => e).toList()
            : null,
        levelOfCompleteness: json["level_of_completeness"] != null
            ? json["level_of_completeness"]
            : null,
        degreeOfSucking: json["degree_of_not_sucking"] != null
            ? json["degree_of_not_sucking"]
            : null,
      );

  Map<String, dynamic> toMap({
    bool strict = false,
  }) {
    Map<String, dynamic> map = {
      "title": title != null ? title : null,
      "description": description != null ? description : null,
      "tags": tags != null ? tags.map((dynamic e) => '"$e"').toList().toString() : null,
      "level_of_completeness":
          levelOfCompleteness != null ? levelOfCompleteness.toString() : null,
      'degree_of_not_sucking':
          degreeOfSucking != null ? degreeOfSucking.toString() : null,
    };

    if (strict) {
      Map<String, dynamic> newMap = {};

      for (String el in map.keys) {
        if (map[el] != null) {
          newMap[el] = map[el];
        }
      }
      map = newMap;
    }
    return map;
  }

  @override
  List<Object> get props => [
        title,
        description,
        tags,
        levelOfCompleteness,
        degreeOfSucking,
      ];
}
