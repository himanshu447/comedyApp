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
    this.withoutPromptId,
    this.withoutPromptDescription,
  });

  final int id;
  final int promptId;
  final String deviceToken;
  final String question;
  final String sampleAnswer;
  final String answer;
  final String title;
  List<String> tags;
  final int levelOfCompleteness;
  final int degreeOfNotSucking;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int withoutPromptId;
  final String withoutPromptDescription;

  factory MySavedModel.fromMap(Map<String, dynamic> json) => MySavedModel(
        id: json["id"] != null ? json["id"] : null,
        promptId: json["prompt_id"] != null ? json["prompt_id"] : null,
        deviceToken: json["device_token"] != null ? json["device_token"] : null,
        question: json["question"] != null ? json["question"] : null,
        sampleAnswer:
            json["sample_answer"] != null ? json["sample_answer"] : null,
        answer: json["answer"] != null ? json["answer"] : null,
        title: json["title"] != null ? json["title"] : null,
        tags: List<String>.from(json["tags"].map((x) => x)),
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
        withoutPromptId: json["without_prompts_id"] != null
            ? json["without_prompts_id"]
            : null,
        withoutPromptDescription: json["without_prompts_description"] != null
            ? json["without_prompts_description"]
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

  MySavedModel copyWith({
    final int id,
    final int promptId,
    final String deviceToken,
    final String question,
    final String sampleAnswer,
    final String answer,
    final String title,
    List<String> tags,
    final int levelOfCompleteness,
    final int degreeOfNotSucking,
    final String status,
    final DateTime createdAt,
    final DateTime updatedAt,
    final int withoutPromptId,
    final String withoutPromptDescription,
  }) {
    return MySavedModel(
      id: id ?? this.id,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      levelOfCompleteness: levelOfCompleteness ?? this.levelOfCompleteness,
      degreeOfNotSucking: degreeOfNotSucking ?? this.degreeOfNotSucking,
      answer: answer ?? this.answer,
      sampleAnswer: sampleAnswer ?? this.sampleAnswer,
      question: question ?? this.question,
      tags: tags ?? this.tags,
      title: title ?? this.title,
      withoutPromptId: withoutPromptId ?? this.withoutPromptId,
      deviceToken: deviceToken ?? this.deviceToken,
      promptId: promptId ?? this.promptId,
      withoutPromptDescription:
          withoutPromptDescription ?? this.withoutPromptDescription,
    );
  }
}
