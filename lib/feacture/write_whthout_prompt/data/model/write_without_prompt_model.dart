import 'package:equatable/equatable.dart';

class WriteWithoutPromptModel extends Equatable {
  final String title;
  final String description;
  final List<String> tags;
  final int levelOfCompleteness;
  final int degreeOfSucking;

  WriteWithoutPromptModel({
    this.title,
    this.description,
    this.tags,
    this.levelOfCompleteness,
    this.degreeOfSucking,
  });

  factory WriteWithoutPromptModel.fromMap(Map<String, dynamic> json) =>
      WriteWithoutPromptModel(
        title: json["title"],
        description: json["description"],
        tags: json["tags"],
        levelOfCompleteness: json["levelOfCompleteness"],
        degreeOfSucking: json["degreeOfSucking"],
      );

  Map<String, dynamic> toMap() => {
        "title": title,
        "description": description,
        "tags": tags,
        "levelOfCompleteness": levelOfCompleteness,
        'degreeOfSucking': degreeOfSucking,
      };

  @override
  List<Object> get props => [
        title,
        description,
        tags,
        levelOfCompleteness,
        degreeOfSucking,
      ];
}
