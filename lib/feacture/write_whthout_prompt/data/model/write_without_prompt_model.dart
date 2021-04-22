import 'package:equatable/equatable.dart';

class WriteWithoutPromptModel extends Equatable {
  final String title;
  final String description;
  final List<String> tags;
  final int levelOfCompleteness;
  final int degreeOfSucking;
  final int id;
  final DateTime updatedAt;
  final DateTime createdAt;

  WriteWithoutPromptModel({
    this.id,
    this.title,
    this.description,
    this.tags,
    this.levelOfCompleteness,
    this.degreeOfSucking,
    this.createdAt,
    this.updatedAt,
  });

  factory WriteWithoutPromptModel.fromMap(Map<String, dynamic> json) =>
      WriteWithoutPromptModel(
        title: json["title"],
        tags: List<String>.from(json["tags"].map((x) => x)),
        description: json["description"],
        levelOfCompleteness: json["level_of_completeness"],
        degreeOfSucking: json["degree_of_not_sucking"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toMap({bool strict = false}) {
    Map<String, dynamic> map = {
      "title": title != null ? title : null,
      "tags": tags != null ? tags.map((dynamic e) => '"$e"').toList().toString() : null,
      "description": description != null ? description : null,
      "level_of_completeness": levelOfCompleteness != null ? levelOfCompleteness.toString() : null,
      "degree_of_not_sucking": degreeOfSucking != null ? degreeOfSucking.toString() : null,
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

  WriteWithoutPromptModel copyWith({
    final String title,
    final String description,
    final List<String> tags,
    final int levelOfCompleteness,
    final int degreeOfSucking,
    final int id,
    final DateTime updatedAt,
    final DateTime createdAt,
  }) {
    return WriteWithoutPromptModel(
      id: id ?? this.id,
      title: title ?? this.title,
      tags: tags ?? this.tags,
      levelOfCompleteness: levelOfCompleteness ?? this.levelOfCompleteness,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
      degreeOfSucking: degreeOfSucking ?? this.degreeOfSucking,
      description: description ?? this.description,
    );
  }

  @override
  List<Object> get props => [
        id,
        title,
        tags,
        levelOfCompleteness,
        description,
        degreeOfSucking,
      ];
}
