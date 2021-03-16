import 'package:comedy/feacture/submit_prompt/data/model/submit_prompt_model.dart';
import 'package:comedy/feacture/submit_prompt/presentation/bloc/submit_prompt_bloc.dart';
import 'package:comedy/injector.dart';
import 'package:comedy/share/widget/top_app_bar_widget.dart';
import 'package:comedy/utils/color_util.dart';
import 'package:comedy/utils/component/text_component.dart';
import 'package:comedy/utils/icons_utils.dart';
import 'package:comedy/utils/string_util.dart';
import 'package:comedy/utils/style_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  SubmitPromptBloc _submitPromptBloc;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    _submitPromptBloc = injector<SubmitPromptBloc>();
    super.initState();
  }

  @override
  void dispose() {
    _submitPromptBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: BlocListener(
          listener: (context, state) {
          if(state is SubmitPromptSuccessState){
            _showSuccessDialog();
          }else if(state is SubmitPromptErrorState){
            showSnackBar(msg: state.errorMessage);
          }
        },
        child: BlocBuilder<SubmitPromptBloc, SubmitPromptState>(
            cubit: _submitPromptBloc,
            builder: (context, state) {
              if (state is SubmitPromptLoadingState) {
                return loadBody(isDataLoading: true);
              } else {
                return loadBody();
              }
            }),
      ),
    );
  }

  Widget loadBody({bool isDataLoading = false}) {
    return Stack(
      children: [
        SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TopAppBarWidget(
                  title: AppString.laugh_draft,
                  subTitle: TextComponent(
                    title: AppString.submit_prompt_top_desc,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: AppColor.white,
                    textAlign: TextAlign.center,
                    margin: EdgeInsets.only(top: 60, right: 20, left: 20),
                  ),
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
        ),
        Positioned(
          top: 0,
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            color: Colors.black26,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      ],
    );
  }

  _submitData() {
    if (_formKey.currentState.validate()) {
      _submitPromptBloc.add(
        SubmitPromptResultEvent(
          submitPromptModel: SubmitPromptModel(
            email: _emailController.text.trim(),
            name: _nameController.text.trim(),
            description: _promptTextController.text.trim(),
            website: _websiteController.text.trim(),
          ),
        ),
      );
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
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              child: RawMaterialButton(
                onPressed: () => Navigator.pop(context),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
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

  showSnackBar({String msg}) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: TextComponent(
          title: msg,
        ),
      ),
    );
  }

}
