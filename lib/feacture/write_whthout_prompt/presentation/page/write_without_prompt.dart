import 'package:comedy/common/general_widget.dart';
import 'package:comedy/feacture/write_whthout_prompt/data/model/write_without_prompt_model.dart';
import 'package:comedy/feacture/write_whthout_prompt/presentation/bloc/write_without_prompt_bloc.dart';
import 'package:comedy/injector.dart';
import 'package:comedy/share/widget/auto_filled_date_widget.dart';
import 'package:comedy/share/widget/custom_dialog_widget.dart';
import 'package:comedy/share/widget/sub_module_app_bar_widget.dart';
import 'package:comedy/utils/color_util.dart';
import 'package:comedy/utils/component/input-chip.component.dart';
import 'package:comedy/utils/component/number_slider_component.dart';
import 'package:comedy/utils/component/text_component.dart';
import 'package:comedy/utils/icons_utils.dart';
import 'package:comedy/utils/route/route_name.dart';
import 'package:comedy/utils/route/screen_argument_model/write_without_prompt_detail_arguments.dart';
import 'package:comedy/utils/string_util.dart';
import 'package:comedy/utils/style_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WriteWithoutPromptView extends StatefulWidget {
  @override
  _WriteWithoutPromptViewState createState() => _WriteWithoutPromptViewState();
}

class _WriteWithoutPromptViewState extends State<WriteWithoutPromptView> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _promptController = TextEditingController();

  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _promptFocusNode = FocusNode();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isPromptTitleAndDescSubmitted = false;
  bool isTagSubmitted = false;
  bool isLevelOfCompletenessSubmitted = false;

  List<String> tagList = [];

  int degreeOfSucking = 5;
  int levelOfCompleteness = 5;

  WriteWithoutPromptBloc withoutPromptBloc;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    withoutPromptBloc = injector<WriteWithoutPromptBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: BlocListener(
        listener: (_, state) {
          if (state is WriteWithoutPromptSubmittingState) {
            CustomDialogs.showSavingDataDialog(
              context: context,
              title: AppString.saving_your_writing,
            );
          } else if (state is WriteWithoutPromptSuccessState) {
            Navigator.pop(context);

            Navigator.popAndPushNamed(
                context, RouteName.write_without_prompt_detail,
                arguments: WriteWithoutPromptDetailScreenArguments(
                  writeWithoutPromptModel: WriteWithoutPromptModel(
                    title: state.writeWithoutPromptModel.title,
                    description: state.writeWithoutPromptModel.description,
                    degreeOfSucking:
                        state.writeWithoutPromptModel.degreeOfSucking,
                    levelOfCompleteness:
                        state.writeWithoutPromptModel.levelOfCompleteness,
                    tags: state.writeWithoutPromptModel.tags,
                    id: state.writeWithoutPromptModel.id,
                  ),
                  withoutPromptBloc: withoutPromptBloc,
                ));
          } else if (state is WriteWithoutPromptErrorState) {
            Navigator.pop(context);
            showSnackBar(msg: state.error);
          }
        },
        cubit: withoutPromptBloc,
        child: BlocBuilder<WriteWithoutPromptBloc, WriteWithoutPromptState>(
            cubit: withoutPromptBloc,
            builder: (context, snapshot) {
              return _loadBody();
            }),
      ),
    );
  }

  Widget _loadBody() {
    return Stack(
      fit: StackFit.expand,
      children: [
        SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 50),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SubModuleAppBarWidget(
                  color: AppColor.primary_orange[500],
                  title: AppString.free_write,
                  leadingWidget: IconButton(
                    icon: imageAsset(
                      img: AppIcons.ic_back,
                      width: 25.0,
                      height: 25.0,
                      color:AppColor.black,
                    ),
                    onPressed: (){
                      if((_titleController.text.trim().isNotEmpty || _promptController.text.trim().isNotEmpty) &&
                          !isPromptTitleAndDescSubmitted){
                        showConfirmDialog();
                      }else if(isPromptTitleAndDescSubmitted && isTagSubmitted){
                        setState(() {
                          isTagSubmitted = false;
                        });
                      }else if(isPromptTitleAndDescSubmitted){
                        setState(() {
                          isPromptTitleAndDescSubmitted = false;
                        });
                      }else{
                        Navigator.pop(context);
                      }
                    },
                  ),
                  actionWidget:
                      !isPromptTitleAndDescSubmitted || !isTagSubmitted
                          ? FlatButton(
                              onPressed: _submitPromptTitleAndDesc,
                              child: TextComponent(
                                title: AppString.done,
                                textStyle: StyleUtil.calenderHeaderTextStyle,
                              ),
                            )
                          : null,
                ),
                AutoFilledDateWidget(),
                isPromptTitleAndDescSubmitted
                    ? TextComponent(
                        title: _titleController.text.trim(),
                        textStyle: StyleUtil.calenderHeaderTextStyle,
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        child: TextFormField(
                          controller: _titleController,
                          focusNode: _titleFocusNode,
                          textInputAction: TextInputAction.next,
                          onTap: () {
                            setState(() {
                              FocusScope.of(context)
                                  .requestFocus(_titleFocusNode);
                            });
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return AppString.error_required_prompt_title;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: AppString.hint_prompt_title,
                            fillColor: _titleFocusNode.hasFocus
                                ? AppColor.white
                                : AppColor.textFieldBgColor,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: _titleFocusNode.hasFocus
                                    ? Colors.black
                                    : AppColor.textFieldBgColor,
                                width: 0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                color: Colors.black,
                                width: 0,
                              ),
                            ),
                          ),
                        ),
                      ),
                isPromptTitleAndDescSubmitted
                    ? TextComponent(
                        title: _promptController.text.trim(),
                        textStyle: StyleUtil.formFieldTextStyle,
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        child: TextFormField(
                          controller: _promptController,
                          focusNode: _promptFocusNode,
                          maxLines: 8,
                          onTap: () {
                            setState(() {
                              FocusScope.of(context)
                                  .requestFocus(_promptFocusNode);
                            });
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return AppString.error_required_prompt;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: AppString.hint_prompt_here,
                            fillColor: _promptFocusNode.hasFocus
                                ? AppColor.white
                                : AppColor.textFieldBgColor,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: _promptFocusNode.hasFocus
                                    ? Colors.black
                                    : AppColor.textFieldBgColor,
                                width: 0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                color: Colors.black,
                                width: 0,
                              ),
                            ),
                          ),
                        ),
                      ),
                isPromptTitleAndDescSubmitted
                    ? InputChipComponent(
                        list: tagList,
                        hintText: AppString.hint_prompt_has_tag,
                        chipColor: AppColor.primary_orange[100],
                        chipTextColor: AppColor.primary_orange[500],
                        keyboardType: TextInputType.text,
                        isTextFieldVisible: !isTagSubmitted,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ).copyWith(top: 14, bottom: 14),
                        onAddCallBack: (val) {
                          if (val.isNotEmpty) {
                            setState(() {
                              tagList.add('#${val.trim()}');
                            });
                          }
                        },
                      )
                    : Container(),
                isTagSubmitted && !isLevelOfCompletenessSubmitted
                    ? TextComponent(
                        title: AppString.level_of_completeness,
                        textStyle: StyleUtil.levelOfCompletenessTextStyle,
                        margin: EdgeInsets.only(top: 30),
                        textAlign: TextAlign.center,
                      )
                    : Container(),
                isTagSubmitted && !isLevelOfCompletenessSubmitted
                    ? HorizantalPicker(
                        minValue: 1,
                        maxValue: 10,
                        onChanged: (val) {
                          levelOfCompleteness = val;
                        },
                        activeItemBgColor: AppColor.primary_orange[100],
                        activeTextStyle: StyleUtil.activeNumberTextStyle,
                        deActiveTextStyle: StyleUtil.inActiveNumberTextStyle,
                      )
                    : Container(),
                isLevelOfCompletenessSubmitted
                    ? TextComponent(
                        title: AppString.degree_of_not_sucking,
                        textStyle: StyleUtil.levelOfCompletenessTextStyle,
                        margin: EdgeInsets.only(top: 30),
                        textAlign: TextAlign.center,
                      )
                    : Container(),
                isLevelOfCompletenessSubmitted
                    ? HorizantalPicker(
                        minValue: 1,
                        maxValue: 10,
                        onChanged: (val) {
                          degreeOfSucking = val;
                        },
                        activeItemBgColor: AppColor.primary_orange[100],
                        activeTextStyle: StyleUtil.activeNumberTextStyle,
                        deActiveTextStyle: StyleUtil.inActiveNumberTextStyle,
                      )
                    : Container(),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          left: 20,
          right: 20,
          child: MediaQuery.of(context).viewInsets.bottom == 0 &&
                  isPromptTitleAndDescSubmitted &&
                  isTagSubmitted
              ? RawMaterialButton(
                  onPressed: _submitPromptTitleAndDesc,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  fillColor: AppColor.primary_orange[500],
                  child: TextComponent(
                    title: AppString.next,
                    textStyle: StyleUtil.nextButtonTextStyle,
                  ),
                )
              : Container(),
        )
      ],
    );
  }

  _submitPromptTitleAndDesc() {
    if (!isPromptTitleAndDescSubmitted) {
      if (_formKey.currentState.validate()) {
        setState(() {
          isPromptTitleAndDescSubmitted = true;
        });
      }
    } else if (!isTagSubmitted) {
      setState(() {
        isTagSubmitted = true;
      });
    } else if (isTagSubmitted && !isLevelOfCompletenessSubmitted) {
      setState(() {
        isLevelOfCompletenessSubmitted = true;
      });
    } else if (isLevelOfCompletenessSubmitted) {
      withoutPromptBloc.add(
        CreateWriteWithoutPromptEvent(
          writeWithoutPromptModel: WriteWithoutPromptModel(
            title: _titleController.text.trim(),
            description: _promptController.text.trim(),
            degreeOfSucking: degreeOfSucking,
            levelOfCompleteness: levelOfCompleteness,
            tags: tagList,
          ),
        ),
      );
    }
  }

  showSnackBar({String msg}) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: TextComponent(
          title: msg,
          color: AppColor.white,
          fontSize: 16,
        ),
      ),
    );
  }

  showConfirmDialog(){
    showDialog(
      context: context,
      builder: (_) =>  AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: AppColor.white,
        contentPadding: EdgeInsets.zero,
        title: TextComponent(
          title: AppString.back_confirm_dialog,
          textStyle: StyleUtil.formFieldTextStyle,
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 20,
            ),
            Divider(),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: FlatButton(
                      onPressed: () => Navigator.pop(context),
                      child: TextComponent(
                        title: AppString.cancel,
                        textStyle: StyleUtil.calenderHeaderTextStyle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  VerticalDivider(),
                  Expanded(
                    child: FlatButton(
                      onPressed:(){
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: TextComponent(
                        title: AppString.yes,
                        textStyle: StyleUtil.calenderHeaderTextStyle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*
Container(
                  width: double.infinity,
                  color: AppColor.primary_orange[500],
                  padding: EdgeInsets.only(top: AppBar().preferredSize.height),
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    dense: false,
                    leading: IconButton(
                      icon: imageAsset(
                        img: AppIcons.ic_back,
                        width: 25.0,
                        height: 25.0,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    title: TextComponent(
                      title: AppString.free_write,
                      textStyle: StyleUtil.appBarTextStyle,
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      textAlign: TextAlign.center,
                    ),
                    trailing: !isPromptTitleAndDescSubmitted || !isTagSubmitted
                        ? FlatButton(
                            onPressed: _submitPromptTitleAndDesc,
                            child: TextComponent(
                              title: AppString.done,
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        : Container(),
                  ),
                ),
 */
