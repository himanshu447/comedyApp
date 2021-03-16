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
        title: json['title'] == null ? null : json["title"],
        description: json["description"] == null ? null : json["description"],
        tags: json["tags"] == null ? null : json["tags"],
        levelOfCompleteness: json["levelOfCompleteness"] == null ? null :json["levelOfCompleteness"],
        degreeOfSucking: json["degreeOfSucking"]== null ? null: json["degreeOfSucking"],
      );

  Map<String, dynamic> toMap() => {
    'title': title != null ? title : null,
        "description": description != null ? description : null,
        "tags": tags != null ?tags : null,
        "levelOfCompleteness": levelOfCompleteness != null ? levelOfCompleteness : null,
        'degreeOfSucking': degreeOfSucking != null ? degreeOfSucking : null,
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
