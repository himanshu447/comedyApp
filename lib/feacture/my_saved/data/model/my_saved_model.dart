class MySavedModel {
  MySavedModel({
    this.id,
    this.promptId,
    this.deviceToken,
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

  final int id;
  final int promptId;
  final String deviceToken;
  final String question;
  final String sampleAnswer;
  final String answer;
  final String title;
  final String tags;
  final int levelOfCompleteness;
  final int degreeOfNotSucking;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory MySavedModel.fromMap(Map<String, dynamic> json) => MySavedModel(
        id: json["id"] != null ? json["id"] : null,
        promptId: json["prompt_id"] != null ? json["prompt_id"] : null,
        deviceToken: json["device_token"] != null ? json["device_token"] : null,
        question: json["question"] != null ? json["question"] : null,
        sampleAnswer:
            json["sample_answer"] != null ? json["sample_answer"] : null,
        answer: json["answer"] != null ? json["answer"] : null,
        title: json["title"] != null ? json["title"] : null,
        tags: json["tags"],
        levelOfCompleteness: json["level_of_completeness"] != null
            ? json["level_of_completeness"]
            : null,
        degreeOfNotSucking: json["degree_of_not_sucking"] != null
            ? json["degree_of_not_sucking"]
            : null,
        status: json["status"] != null ? json["status"] : null,
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"])
            : null,
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "prompt_id": promptId,
        "device_token": deviceToken,
        "question": question,
        "sample_answer": sampleAnswer,
        "answer": answer,
        "title": title,
        "tags": tags,
        "level_of_completeness": levelOfCompleteness,
        "degree_of_not_sucking": degreeOfNotSucking,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
