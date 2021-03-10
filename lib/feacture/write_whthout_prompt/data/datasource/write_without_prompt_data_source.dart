import 'package:comedy/share/service/web_service.dart';

abstract class WriteWithoutPromptDataSource {
  Future<dynamic> submitPrompt();
}

class WriteWithoutPromptDataSourceImpl extends WriteWithoutPromptDataSource {
  final WebService webService;

  WriteWithoutPromptDataSourceImpl({
    this.webService,
  });

  @override
  Future submitPrompt() {}
}
