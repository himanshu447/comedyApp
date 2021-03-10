import 'package:equatable/equatable.dart';

class SubmitPromptModel extends Equatable {
  final String name;
  final String email;
  final String website;
  final String desc;

  SubmitPromptModel({
    this.name,
    this.email,
    this.website,
    this.desc,
  });

  @override
  List<Object> get props => [
        name,
        email,
        website,
        desc,
      ];
}
