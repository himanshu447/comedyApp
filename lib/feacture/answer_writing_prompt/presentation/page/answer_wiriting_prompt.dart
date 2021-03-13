import 'dart:async';
import 'package:comedy/feacture/write_whthout_prompt/data/model/write_without_prompt_model.dart';
import 'package:comedy/share/widget/auto_filled_date_widget.dart';
import 'package:comedy/share/widget/custom_dialog_widget.dart';
import 'package:comedy/share/widget/sub_module_app_bar_widget.dart';
import 'package:comedy/utils/color_util.dart';
import 'package:comedy/utils/component/input-chip.component.dart';
import 'package:comedy/utils/component/number_slider_component.dart';
import 'package:comedy/utils/component/text_component.dart';
import 'package:comedy/utils/constant_util.dart';
import 'package:comedy/utils/helper/timer_helper.dart';
import 'package:comedy/utils/icons_utils.dart';
import 'package:comedy/utils/route/route_name.dart';
import 'package:comedy/utils/string_util.dart';
import 'package:comedy/utils/style_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnswerWritingPromptView extends StatefulWidget {
  @override
  _AnswerWritingPromptViewState createState() =>
      _AnswerWritingPromptViewState();
}

class _AnswerWritingPromptViewState extends State<AnswerWritingPromptView> {
  final TextEditingController _answerController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();

  final GlobalKey<FormState> _answerFormKey = GlobalKey();
  final FocusNode _answerFocusNode = FocusNode();
  final FocusNode _titleFocusNode = FocusNode();

  List<String> tagList = [];

  Timer _timer;
  int _start = ConstantUtil.START_TIMER_VALUE;

  bool isAnswerSavedButtonPress = false;
  bool isAnswerSubmitRequest = false;
  bool isTitleSubmit = false;
  bool isTagSubmitted = false;
  bool isLevelOfCompletenessSubmitted = false;

  int degreeOfSucking = 3;
  int levelOfCompleteness = 3;

  void _startTimer() {
    const oneSec = const Duration(seconds: 1);

    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == ConstantUtil.END_TIMER_VALUE) {
          isAnswerSubmitRequest = true;
          _showTimeUpDialog();
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start++;
          });
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loadBody(),
    );
  }

  Widget _loadBody() {
    return Stack(
      fit: StackFit.expand,
      children: [
        SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 50),
          child: Form(
            key: _answerFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SubModuleAppBarWidget(
                  color: AppColor.primary_green[500],
                  title: !isAnswerSavedButtonPress
                      ? TimerHelper.formatHHMMSS(_start)
                      : AppString.write_prompt,
                  actionWidget: FlatButton(
                    onPressed: (!isAnswerSubmitRequest) ||
                            (isAnswerSavedButtonPress && !isTagSubmitted)
                        ? _submitData
                        : null,
                    child: TextComponent(
                      title: (!isAnswerSubmitRequest) ||
                              (isAnswerSavedButtonPress && !isTagSubmitted)
                          ? AppString.done
                          : '',
                      textStyle: StyleUtil.calenderHeaderTextStyle,
                    ),
                  ),
                ),
                AutoFilledDateWidget(),
                isAnswerSavedButtonPress
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        child: !isTitleSubmit
                            ? TextFormField(
                                controller: _titleController,
                                focusNode: _titleFocusNode,
                                textInputAction: TextInputAction.done,
                                onTap: () {
                                  setState(() {
                                    FocusScope.of(context)
                                        .requestFocus(_titleFocusNode);
                                  });
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return AppString
                                        .error_required_prompt_title;
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
                              )
                            : TextComponent(
                                title: _titleController.text.trim(),
                                textStyle: StyleUtil.calenderHeaderTextStyle,
                              ),
                      )
                    : Container(),
                !isAnswerSavedButtonPress
                    ? TextComponent(
                        title: AppString.write_prompt,
                        textStyle:
                            StyleUtil.levelOfCompletenessTextStyle.copyWith(
                          color: AppColor.primary_green[500],
                        ),
                        margin: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                      )
                    : Container(),
                TextComponent(
                  title: _start != ConstantUtil.END_TIMER_VALUE
                      ? !isAnswerSubmitRequest
                          ? AppString.write_prompt_question
                          : _answerController.text.trim()
                      : _answerController.text.trim(),
                  textStyle: StyleUtil.formFieldTextStyle,
                  margin: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                ),
                _start != ConstantUtil.END_TIMER_VALUE
                    ? !isAnswerSubmitRequest
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 16),
                            child: Text.rich(
                              TextSpan(
                                text: '',
                                style: StyleUtil.formFieldTextStyle,
                                children: [
                                  TextSpan(
                                    text: AppString.example,
                                    style:
                                        StyleUtil.formFieldTextStyle.copyWith(
                                      color: AppColor.primary_green[500],
                                    ),
                                  ),
                                  TextSpan(
                                    text: AppString.write_prompt_example_answer,
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Container()
                    : Container(),
                isTitleSubmit
                    ? InputChipComponent(
                        list: tagList,
                        hintText: AppString.hint_prompt_has_tag,
                        chipColor: AppColor.primary_green[100],
                        chipTextColor: AppColor.primary_green[500],
                        keyboardType: TextInputType.text,
                        isTextFieldVisible: !isTagSubmitted,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 50,
                        ).copyWith(top: 34, bottom: 14),
                        onAddCallBack: (val) {
                          setState(() {
                            tagList.add(val.trim());
                          });
                        },
                      )
                    : Container(),
                isTagSubmitted && !isLevelOfCompletenessSubmitted
                    ? TextComponent(
                        title: AppString.level_of_completeness,
                        textStyle: StyleUtil.levelOfCompletenessTextStyle,
                        margin: EdgeInsets.only(top: 60),
                        textAlign: TextAlign.center,
                      )
                    : Container(),
                isTagSubmitted && !isLevelOfCompletenessSubmitted
                    ? HorizantalPicker(
                        minValue: 1,
                        maxValue: 10,
                        onChanged: (val) {
                          print(val);
                          levelOfCompleteness = val;
                        },
                        activeItemBgColor: AppColor.primary_green[100],
                        activeTextStyle: StyleUtil.activeNumberTextStyle
                            .copyWith(color: AppColor.primary_green[500]),
                        deActiveTextStyle: StyleUtil.inActiveNumberTextStyle,
                      )
                    : Container(),
                isLevelOfCompletenessSubmitted
                    ? TextComponent(
                        title: AppString.degree_of_not_sucking,
                        textStyle: StyleUtil.levelOfCompletenessTextStyle,
                        margin: EdgeInsets.only(top: 60),
                        textAlign: TextAlign.center,
                      )
                    : Container(),
                isLevelOfCompletenessSubmitted
                    ? HorizantalPicker(
                        minValue: 1,
                        maxValue: 10,
                        onChanged: (val) {
                          print(val);
                          degreeOfSucking = val;
                        },
                        activeItemBgColor: AppColor.primary_green[100],
                        activeTextStyle: StyleUtil.activeNumberTextStyle
                            .copyWith(color: AppColor.primary_green[500]),
                        deActiveTextStyle: StyleUtil.inActiveNumberTextStyle,
                      )
                    : Container(),
                _start != ConstantUtil.END_TIMER_VALUE
                    ? !isAnswerSubmitRequest
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 20,
                            ),
                            child: TextFormField(
                              controller: _answerController,
                              focusNode: _answerFocusNode,
                              maxLines: 6,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return AppString
                                      .error_answer_writing_prompt_here;
                                }
                                return null;
                              },
                              onTap: () {
                                setState(() {
                                  FocusScope.of(context)
                                      .requestFocus(_answerFocusNode);
                                });
                              },
                              decoration: InputDecoration(
                                hintText:
                                    AppString.hit_answer_writing_prompt_here,
                                fillColor: _answerFocusNode.hasFocus
                                    ? AppColor.white
                                    : AppColor.textFieldBgColor,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                    color: _answerFocusNode.hasFocus
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
                          )
                        : Container()
                    : Container(),
              ],
            ),
          ),
        ),
        (_start == ConstantUtil.END_TIMER_VALUE || isAnswerSubmitRequest) &&
                MediaQuery.of(context).viewInsets.bottom == 0 &&
                !isAnswerSavedButtonPress
            ? Positioned(
                bottom: 10,
                left: 20,
                right: 20,
                child: RawMaterialButton(
                  onPressed: () {
                    setState(() {
                      isAnswerSavedButtonPress = true;
                    });
                  },
                  fillColor: AppColor.primary_green[500],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: TextComponent(
                    title: AppString.save,
                    textStyle: StyleUtil.nextButtonTextStyle,
                  ),
                ),
              )
            : Container(),
        Positioned(
          bottom: 10,
          left: 20,
          right: 20,
          child: MediaQuery.of(context).viewInsets.bottom == 0 && isTagSubmitted
              ? RawMaterialButton(
                  onPressed: _submitData,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  fillColor: AppColor.primary_green[500],
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

  _showTimeUpDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AppIcons.ic_time_up,
                height: 116,
              ),
              TextComponent(
                title: AppString.time_up,
                textStyle: StyleUtil.calenderHeaderTextStyle,
                textAlign: TextAlign.center,
                margin: EdgeInsets.symmetric(vertical: 26),
              ),
              Container(
                height: 200,
                color: AppColor.gry,
                alignment: Alignment.center,
                margin: EdgeInsets.only(bottom: 20),
                child: TextComponent(
                  title: 'Add',
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: RawMaterialButton(
                  onPressed: () => Navigator.pop(context),
                  padding: EdgeInsets.symmetric(vertical: 15),
                  fillColor: AppColor.primary_green[500],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextComponent(
                    title: AppString.ok,
                    textStyle: StyleUtil.nextButtonTextStyle,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _submitData() {
    if (_answerFormKey.currentState.validate() && !isAnswerSubmitRequest) {
      print('IF');
      setState(() {
        isAnswerSubmitRequest = true;
      });
      _timer.cancel();
    } else if (_answerFormKey.currentState.validate() && !isTitleSubmit) {
      print('TitleSubmit');
      setState(() {
        isTitleSubmit = true;
      });
    } else if (!isTagSubmitted && isTitleSubmit) {
      print('TAG Sub');
      setState(() {
        isTagSubmitted = true;
      });
    } else if (!isLevelOfCompletenessSubmitted && isTagSubmitted) {
      print('Level ');
      setState(() {
        isLevelOfCompletenessSubmitted = true;
      });
    } else if (isLevelOfCompletenessSubmitted &&
        isTagSubmitted &&
        _answerController.text.trim().isNotEmpty &&
        _titleController.text.trim().isNotEmpty) {
      CustomDialogs.showSavingDataDialog(
        context: context,
      );
      Future.delayed(
        Duration(
          seconds: 1,
        ),
      ).then(
        (value) => Navigator.popAndPushNamed(
          context,
          RouteName.answer_writing_prompt_detail,
          arguments: WriteWithoutPromptModel(
            title: _titleController.text.trim(),
            description: _answerController.text.trim(),
            degreeOfSucking: degreeOfSucking,
            levelOfCompleteness: levelOfCompleteness,
            tags: tagList,
          ),
        ),
      );
    } else {
      return;
    }
  }
}
