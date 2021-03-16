import 'package:comedy/feacture/write_whthout_prompt/data/model/write_without_prompt_model.dart';
import 'package:comedy/feacture/write_whthout_prompt/presentation/bloc/write_without_prompt_bloc.dart';

class WriteWithoutPromptDetailScreenArguments {
  final WriteWithoutPromptModel writeWithoutPromptModel;
  final WriteWithoutPromptBloc withoutPromptBloc;

  WriteWithoutPromptDetailScreenArguments({
    this.writeWithoutPromptModel,
    this.withoutPromptBloc,
  });
}
