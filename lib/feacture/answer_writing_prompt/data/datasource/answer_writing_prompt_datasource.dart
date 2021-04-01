import 'package:comedy/feacture/answer_writing_prompt/data/model/answer_write_prompt_model.dart';
import 'package:comedy/feacture/answer_writing_prompt/data/model/question_answer_model.dart';
import 'package:comedy/share/data/datasource/save_prompt_data_source.dart';
import 'package:comedy/share/service/service.dart';
import 'package:comedy/share/service/web_service.dart';
import 'package:comedy/utils/constant_util.dart';
import 'package:comedy/utils/enum_util.dart';

abstract class AnswerWritingPromptDataSource {
  Future<List<QuestionAnswerModel>> getQuestions();

  Future<AnswerWritePromptModel> createAnswerWritingPrompt(
      {AnswerWritePromptModel answerWritePromptModel});

  Future<bool> deleteAnswerWritingPrompt({int id});

  Future<AnswerWritePromptModel> updateAnswerWritingPrompt(
      {AnswerWritePromptModel answerWritePromptModel});
}

class AnswerWritingPromptDataSourceImpl extends AnswerWritingPromptDataSource {
  final WebService webService;
  final SavePromptDataSource savePromptDataSource;

  AnswerWritingPromptDataSourceImpl({
    this.webService,
    this.savePromptDataSource,
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
  Future<AnswerWritePromptModel> createAnswerWritingPrompt(
      {AnswerWritePromptModel answerWritePromptModel}) async {
    try {
      var result = await webService.requestPOST(
          url: Services.getServices(
            EndPoint.CreateAnswerWritingPrompt,
          ),
          body: answerWritePromptModel.toMap(strict: true));
      print(result);

      if (result[ConstantUtil.result_success]) {
        await savePromptDataSource.savePrompt(
          answerPromptId: result[ConstantUtil.result_response]['data']['id'],
        );
        return AnswerWritePromptModel.fromMap(
          result[ConstantUtil.result_response]['data'],
        );
      } else {
        print(result[ConstantUtil.result_response]);
        throw result[ConstantUtil.result_response];
      }
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  @override
  Future<AnswerWritePromptModel> updateAnswerWritingPrompt(
      {AnswerWritePromptModel answerWritePromptModel}) async {
    try {
      var result = await webService.requestPOST(
          url: Services.getServices(
                EndPoint.UpdateAnswerWritingPrompt,
              ) +
              '${answerWritePromptModel.id}',
          body: answerWritePromptModel.toMap(strict: true));
      print(result);
      if (result[ConstantUtil.result_success]) {
        return AnswerWritePromptModel.fromMap(
            result[ConstantUtil.result_response]['data']);
      } else {
        print(result[ConstantUtil.result_response]);
        throw result[ConstantUtil.result_response];
      }
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  @override
  Future<bool> deleteAnswerWritingPrompt({int id}) async {
    try {
      var result = await webService.requestDelete(
        url: Services.getServices(
              EndPoint.DeleteAnswerWritingPrompt,
            ) +
            '$id',
      );

      print(result);

      if (result[ConstantUtil.result_success]) {
        return true;
      } else {
        print(result[ConstantUtil.result_response]);
        throw result[ConstantUtil.result_response];
      }
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
