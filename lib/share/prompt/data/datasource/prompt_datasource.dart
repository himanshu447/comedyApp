import 'package:comedy/share/service/web_service.dart';

abstract class PromptDataSource {
  Future<dynamic> submitPrompt();
}

class PromptDataSourceImpl extends PromptDataSource {
  final WebService webService;

  PromptDataSourceImpl({
    this.webService,
  });

  @override
  Future submitPrompt() {}
}
