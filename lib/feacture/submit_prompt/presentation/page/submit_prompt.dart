import 'package:comedy/share/widget/top_app_bar_widget.dart';
import 'package:comedy/utils/color_util.dart';
import 'package:comedy/utils/string_util.dart';
import 'package:flutter/material.dart';

class SubmitPromptWidget extends StatefulWidget {
  @override
  _SubmitPromptWidgetState createState() => _SubmitPromptWidgetState();
}

class _SubmitPromptWidgetState extends State<SubmitPromptWidget> {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();
  final TextEditingController _promptTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary_blue[500],
        elevation: 0.0,
      ),
      body: loadBody,
    );
  }

  Widget get loadBody {
    return SingleChildScrollView(
      child: Column(
        children: [
          TopAppBarWidget(
            title: AppString.laugh_draft,
            subTitle: AppString.submit_prompt_top_desc,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 12),
            child: TextFormField(
              controller: _nameController,
            ),
          ),
        ],
      ),
    );
  }
}
