import 'package:comedy/feacture/submit_prompt/data/model/submit_prompt_model.dart';
import 'package:comedy/share/service/service.dart';
import 'package:comedy/share/service/web_service.dart';
import 'package:comedy/utils/constant_util.dart';
import 'package:comedy/utils/enum_util.dart';

abstract class PromptDataSource {
  Future<SubmitPromptModel> submitPrompt({SubmitPromptModel submitPromptModel});
}

class PromptDataSourceImpl extends PromptDataSource {
  final WebService webService;

  PromptDataSourceImpl({
    this.webService,
  });

  @override
  Future<SubmitPromptModel> submitPrompt({SubmitPromptModel submitPromptModel}) async {
    try {
      var result = await webService.requestPOST(
        url: Services.getServices(
          EndPoint.CreatePrompt,
        ),
      );

      print(result);

      if (result[ConstantUtil.result_success]) {

        return SubmitPromptModel.fromMap(result[ConstantUtil.result_response]['data']);

      } else {
        throw result[ConstantUtil.result_response];
      }
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
