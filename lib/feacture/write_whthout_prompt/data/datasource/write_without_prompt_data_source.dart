import 'package:comedy/feacture/write_whthout_prompt/data/model/write_without_prompt_model.dart';
import 'package:comedy/share/data/datasource/save_prompt_data_source.dart';
import 'package:comedy/share/service/service.dart';
import 'package:comedy/share/service/web_service.dart';
import 'package:comedy/utils/constant_util.dart';
import 'package:comedy/utils/enum_util.dart';

abstract class WriteWithoutPromptDataSource {
  Future<WriteWithoutPromptModel> createWriteWithoutPrompt({WriteWithoutPromptModel writeWithoutPromptModel});
  Future<bool> deleteWriteWithoutPrompt({int id});
  Future<WriteWithoutPromptModel> updateWriteWithoutPrompt({WriteWithoutPromptModel writeWithoutPromptModel});
}

class WriteWithoutPromptDataSourceImpl extends WriteWithoutPromptDataSource {
  final WebService webService;
  final SavePromptDataSource savePromptDataSource;

  WriteWithoutPromptDataSourceImpl({
    this.webService,
    this.savePromptDataSource,
  });

  @override
  Future<WriteWithoutPromptModel> createWriteWithoutPrompt({WriteWithoutPromptModel writeWithoutPromptModel}) async{

    try {
      var result = await webService.requestPOST(
        url: Services.getServices(
          EndPoint.CreateWriteWithoutPrompt,
        ),
        body: writeWithoutPromptModel.toMap(strict: true)
      );
      print(result);

      if (result[ConstantUtil.result_success]) {

        await savePromptDataSource.savePrompt(result[ConstantUtil.result_response]['data']['id']);
        return WriteWithoutPromptModel.fromMap(result[ConstantUtil.result_response]['data']);

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
  Future<bool> deleteWriteWithoutPrompt({int id})async {
    try {
      var result = await webService.requestDelete(
          url: Services.getServices(
            EndPoint.DeleteWriteWithoutPrompt,
          ) + '$id',
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

  @override
  Future<WriteWithoutPromptModel> updateWriteWithoutPrompt({WriteWithoutPromptModel writeWithoutPromptModel}) async{
    try {
      var result = await webService.requestPOST(
          url: Services.getServices(
            EndPoint.UpdateWriteWithoutPrompt,
          ) + '${writeWithoutPromptModel.id}',
          body: writeWithoutPromptModel.toMap(strict: true)
      );
      print(result);
      if (result[ConstantUtil.result_success]) {
        return WriteWithoutPromptModel.fromMap(result[ConstantUtil.result_response]['data']);
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
