class AnswerWritePromptModel {
  AnswerWritePromptModel({
    this.id,
    this.question,
    this.sampleAnswer,
    this.answer,
    this.title,
    this.tags,
    this.levelOfCompleteness,
    this.degreeOfNotSucking,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String question;
  String sampleAnswer;
  String answer;
  String title;
  List<String> tags;
  int levelOfCompleteness;
  int degreeOfNotSucking;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  factory AnswerWritePromptModel.fromMap(Map<String, dynamic> json) =>
      AnswerWritePromptModel(
        id: json["id"],
        question: json["question"],
        sampleAnswer: json["sample_answer"],
        answer: json["answer"],
        title: json["title"],
        tags: List<String>.from(json["tags"].map((x) => x)),
        levelOfCompleteness: json["level_of_completeness"],
        degreeOfNotSucking: json["degree_of_not_sucking"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap({
    bool strict = false,
  }) {
    Map<String, dynamic> map = {
      "question": question != null ? question : null,
      "sample_answer": sampleAnswer != null ? sampleAnswer : null,
      "answer": answer != null ? answer : null,
      "title": title != null ? title : null,
      "tags": tags != null
          ? tags.map((dynamic e) => '"$e"').toList().toString()
          : null,
      "level_of_completeness":
          levelOfCompleteness != null ? levelOfCompleteness.toString() : null,
      "degree_of_not_sucking":
          degreeOfNotSucking != null ? degreeOfNotSucking.toString() : null,
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

  AnswerWritePromptModel copyWith({
    int id,
    String question,
    String sampleAnswer,
    String answer,
    String title,
    List<String> tags,
    int levelOfCompleteness,
    int degreeOfNotSucking,
    String status,
    DateTime createdAt,
    DateTime updatedAt,
  }) {
    return AnswerWritePromptModel(
      id: id ?? this.id,
      title: title ?? this.title,
      tags: tags ?? this.tags,
      question: question ?? this.question,
      sampleAnswer: sampleAnswer ?? this.sampleAnswer,
      answer: answer ?? this.answer,
      degreeOfNotSucking: degreeOfNotSucking ?? this.degreeOfNotSucking,
      levelOfCompleteness: levelOfCompleteness ?? this.levelOfCompleteness,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
    );
  }
}
