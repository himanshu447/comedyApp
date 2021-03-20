class QuestionAnswerModel {
  QuestionAnswerModel({
    this.id,
    this.question,
    this.sampleAnswer,
    this.title,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String question;
  String sampleAnswer;
  String title;
  DateTime createdAt;
  DateTime updatedAt;

  factory QuestionAnswerModel.fromMap(Map<String, dynamic> json) => QuestionAnswerModel(
    id: json["id"],
    question: json["question"],
    sampleAnswer: json["sample_answer"],
    title: json["title"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );
}
