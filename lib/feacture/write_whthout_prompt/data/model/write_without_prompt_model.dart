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

  @override
  List<Object> get props => [
        title,
        description,
        tags,
        levelOfCompleteness,
        degreeOfSucking,
      ];
}
