abstract class AnswerWritingPromptDataSource {
  Future<dynamic> getQuestions();
  Future<dynamic> createAnswerWritingPrompt();
}

class AnswerWritingPromptDataSourceImpl extends AnswerWritingPromptDataSource {

  @override
  Future createAnswerWritingPrompt() async{

  }

  @override
  Future getQuestions() {
    throw UnimplementedError();
  }
}
