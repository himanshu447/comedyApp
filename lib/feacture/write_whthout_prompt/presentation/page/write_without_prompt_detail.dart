import 'package:comedy/feacture/write_whthout_prompt/data/model/write_without_prompt_model.dart';
import 'package:flutter/material.dart';

class WriteWithoutPromptDetailView extends StatefulWidget {
  final WriteWithoutPromptModel withoutPromptModel;

  const WriteWithoutPromptDetailView({
    Key key,
    this.withoutPromptModel,
  }) : super(key: key);

  @override
  _WriteWithoutPromptDetailViewState createState() =>
      _WriteWithoutPromptDetailViewState();
}

class _WriteWithoutPromptDetailViewState
    extends State<WriteWithoutPromptDetailView> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
