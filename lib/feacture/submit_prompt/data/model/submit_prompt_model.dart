import 'package:equatable/equatable.dart';

class SubmitPromptModel extends Equatable {
  final int id;
  final String name;
  final String email;
  final String website;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;

  SubmitPromptModel({
    this.id,
    this.name,
    this.email,
    this.website,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory SubmitPromptModel.fromMap(Map<String, dynamic> json) =>
      SubmitPromptModel(
        name: json["name"],
        email: json["email"],
        website: json["website"],
        description: json["description"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toMap() =>
      {
        "name": name,
        "email": email,
        "website": website,
        "description": description,
        //"created_at": createdAt.toIso8601String(),
      };

  @override
  List<Object> get props =>
      [
        id,
        name,
        email,
        website,
        description,
      ];
}
