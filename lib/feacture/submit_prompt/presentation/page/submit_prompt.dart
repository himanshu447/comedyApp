import 'package:comedy/utils/color_util.dart';
import 'package:flutter/material.dart';

class SubmitPromptWidget extends StatefulWidget {
  @override
  _SubmitPromptWidgetState createState() => _SubmitPromptWidgetState();
}

class _SubmitPromptWidgetState extends State<SubmitPromptWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary_blue[500],
      ),
    );
  }

  Widget get loadBody{
    return Container();
  }
}
