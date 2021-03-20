import 'package:comedy/feacture/answer_writing_prompt/data/model/question_answer_model.dart';
import 'package:comedy/share/service/service.dart';
import 'package:comedy/share/service/web_service.dart';
import 'package:comedy/utils/constant_util.dart';
import 'package:comedy/utils/enum_util.dart';

abstract class AnswerWritingPromptDataSource {
  Future<List<QuestionAnswerModel>> getQuestions();

  Future<dynamic> createAnswerWritingPrompt();
}

class AnswerWritingPromptDataSourceImpl extends AnswerWritingPromptDataSource {
  final WebService webService;

  AnswerWritingPromptDataSourceImpl({
    this.webService,
  });

  @override
  Future<List<QuestionAnswerModel>> getQuestions() async {
    try {
      var result = await webService.requestGET(
        url: Services.getServices(
          EndPoint.GetSampleQuestions,
        ),
      );

      print(result);

      if (result[ConstantUtil.result_success]) {
        return (result[ConstantUtil.result_response]['data'] as List)
            .map((e) => QuestionAnswerModel.fromMap(e))
            .toList();
      } else {
        throw result[ConstantUtil.result_response];
      }
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  @override
  Future createAnswerWritingPrompt() async {}
}
