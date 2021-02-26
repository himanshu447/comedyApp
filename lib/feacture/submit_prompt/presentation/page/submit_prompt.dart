import 'package:comedy/share/widget/top_app_bar_widget.dart';
import 'package:comedy/utils/color_util.dart';
import 'package:comedy/utils/component/text_component.dart';
import 'package:comedy/utils/icons_utils.dart';
import 'package:comedy/utils/string_util.dart';
import 'package:comedy/utils/style_util.dart';
import 'package:flutter/cupertino.dart';
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

  final GlobalKey<FormState> _formKey = GlobalKey();

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
      padding: EdgeInsets.only(bottom: 20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TopAppBarWidget(
              title: AppString.laugh_draft,
              subTitle: AppString.submit_prompt_top_desc,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ).copyWith(top: 20),
              child: TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: AppString.hint_your_name,
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return AppString.error_required_name;
                  }
                  return null;
                },
                style: StyleUtil.formFieldTextStyle,
                textInputAction: TextInputAction.next,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
              child: TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: AppString.hint_your_email,
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return AppString.error_required_email;
                  }
                  return null;
                },
                style: StyleUtil.formFieldTextStyle,
                textInputAction: TextInputAction.next,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
              child: TextFormField(
                controller: _websiteController,
                decoration: InputDecoration(
                  hintText: AppString.hint_your_website,
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return AppString.error_required_website;
                  }
                  return null;
                },
                style: StyleUtil.formFieldTextStyle,
                textInputAction: TextInputAction.next,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
              child: TextFormField(
                controller: _promptTextController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: AppString.hint_prompt_text,
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return AppString.error_required_prompt_text;
                  }
                  return null;
                },
                style: StyleUtil.formFieldTextStyle,
                textInputAction: TextInputAction.done,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
              child: RawMaterialButton(
                onPressed: _submitData,
                fillColor: AppColor.primary_blue[500],
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: TextComponent(
                  title: AppString.submit,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: AppColor.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _submitData() {
    if (_formKey.currentState.validate()) {
      _showSuccessDialog();
    }
  }

  _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Image.asset(
          AppIcons.ic_success,
          height: 60,
          width: 60,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextComponent(
              title: AppString.submit_prompt_success_msg,
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: AppColor.black,
              margin: EdgeInsets.only(bottom: 10),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 12),
              child: RawMaterialButton(
                onPressed: () => Navigator.pop(context),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                padding: EdgeInsets.symmetric(vertical: 12),
                fillColor: AppColor.primary_blue[500],
                child: TextComponent(
                  title: AppString.ok,
                  color: AppColor.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
