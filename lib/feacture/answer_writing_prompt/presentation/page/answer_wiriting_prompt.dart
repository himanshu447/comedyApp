import 'dart:async';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:comedy/common/general_widget.dart';
import 'package:comedy/feacture/answer_writing_prompt/data/model/answer_write_prompt_model.dart';
import 'package:comedy/feacture/answer_writing_prompt/data/model/question_answer_model.dart';
import 'package:comedy/feacture/answer_writing_prompt/presentation/bloc/answer_writing_prompt_bloc.dart';
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
import 'package:comedy/utils/route/screen_argument_model/answer_writing_prompt_detail_arguments.dart';
import 'package:comedy/utils/string_util.dart';
import 'package:comedy/utils/style_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnswerWritingPromptView extends StatefulWidget {
  final QuestionAnswerModel questionAnswerModel;

  const AnswerWritingPromptView({this.questionAnswerModel});

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

  AnswerWritingPromptBloc answerWritingPromptBloc;

  List<String> tagList = [];

  Timer _timer;
  int _start = ConstantUtil.START_TIMER_VALUE;

  bool isAnswerSavedButtonPress = false;
  bool isAnswerSubmitRequest = false;
  bool isTitleSubmit = false;
  bool isTagSubmitted = false;
  bool isLevelOfCompletenessSubmitted = false;

  int degreeOfSucking = 5;
  int levelOfCompleteness = 5;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

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
            _start--;
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
  void didChangeDependencies() {
    answerWritingPromptBloc =
        BlocProvider.of<AnswerWritingPromptBloc>(context, listen: true);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: BlocListener(
        listener: (_, state) {
          if (state is AnswerWritingPromptSubmittingState) {
            CustomDialogs.showSavingDataDialog(
              context: context,
              title: AppString.saving_your_writing,
            );
          } else if (state is AnswerWritingPromptSuccessState) {
            Navigator.pop(context);

            Navigator.popAndPushNamed(
                context, RouteName.answer_writing_prompt_detail,
                arguments: AnswerWritingPromptDetailScreenArguments(
                  answerWritePromptModel: AnswerWritePromptModel(
                    title: state.answerWritePromptModel.title,
                    degreeOfNotSucking:
                        state.answerWritePromptModel.degreeOfNotSucking,
                    levelOfCompleteness:
                        state.answerWritePromptModel.levelOfCompleteness,
                    tags: state.answerWritePromptModel.tags,
                    id: state.answerWritePromptModel.id,
                    answer: state.answerWritePromptModel.answer,
                    sampleAnswer: state.answerWritePromptModel.sampleAnswer,
                    question: state.answerWritePromptModel.question,
                  ),
                  answerWritingPromptBloc: answerWritingPromptBloc,
                ));
          } else if (state is ErrorState) {
            Navigator.pop(context);
            showSnackBar(msg: state.error);
          }
        },
        cubit: answerWritingPromptBloc,
        child: BlocBuilder<AnswerWritingPromptBloc, AnswerWritingPromptState>(
          cubit: answerWritingPromptBloc,
          builder: (context, snapshot) {
            return _loadBody();
          },
        ),
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
            key: _answerFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SubModuleAppBarWidget(
                  color: AppColor.primary_green[500],
                  title: !isAnswerSavedButtonPress
                      ? TimerHelper.formatHHMMSS(_start)
                      : AppString.write,
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
                  leadingWidget: IconButton(
                    icon: imageAsset(
                      img: AppIcons.ic_back,
                      width: 25.0,
                      height: 25.0,
                      color:AppColor.black,
                    ),
                    onPressed: (){
                      if(isTagSubmitted && isTitleSubmit){
                        setState(() {
                          isTagSubmitted = false;
                        });
                      }else if(isTitleSubmit){
                        setState(() {
                          isTitleSubmit = false;
                        });
                      }else if(isAnswerSavedButtonPress){
                        setState(() {
                          isAnswerSavedButtonPress = false;
                        });
                      }else if(isAnswerSubmitRequest){
                        setState(() {
                          isAnswerSubmitRequest = false;
                        });
                      }else if(_answerController.text.trim().isNotEmpty){
                       showConfirmDialog();
                      }
                      else{
                        Navigator.pop(context);
                      }
                    },
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
                    ? /*Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                          top: 12,
                          bottom: 12,
                        ),
                        child: Text.rich(TextSpan(
                            text: AppString.response_prompt,
                            style:
                                StyleUtil.levelOfCompletenessTextStyle.copyWith(
                              color: AppColor.primary_green[500],
                            ),
                            children: [
                              TextSpan(
                                text: AppString.response_prompt_five_minute,
                                style: StyleUtil.levelOfCompletenessTextStyle
                                    .copyWith(
                                  color: AppColor.primary_green[500],
                                  fontSize: 18,
                                ),
                              )
                            ])),
                      )*/
                    TextComponent(
                        title: AppString.response_prompt,
                        textStyle:
                            StyleUtil.levelOfCompletenessTextStyle.copyWith(
                          color: AppColor.primary_green[500],
                              fontSize: 20,
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
                          ? widget.questionAnswerModel.question
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
                                    text:
                                        widget.questionAnswerModel.sampleAnswer,
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
                            tagList.add('#${val.trim()}');
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
                          levelOfCompleteness = val;
                        },
                        activeItemBgColor: AppColor.primary_green[100],
                        activeTextStyle: StyleUtil.activeNumberTextStyle.copyWith(color: AppColor.primary_green[500]),
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
      builder: (_) => Dialog(
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
                margin: EdgeInsets.only(bottom: 20),
                child: AdmobBanner(
                  adSize: AdmobBannerSize.MEDIUM_RECTANGLE,
                  adUnitId: ConstantUtil.getBannerAdUnitId(),
                  onBannerCreated: (AdmobBannerController controller) {
                    print('banner created');
                    // Dispose is called automatically for you when Flutter removes the banner from the widget tree.
                    // Normally you don't need to worry about disposing this yourself, it's handled.
                    // If you need direct access to dispose, this is your guy!
                    // controller.dispose();
                  },
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

      setState(() {
        isTagSubmitted = true;
      });
      print('TAG Sub');
    } else if (!isLevelOfCompletenessSubmitted && isTagSubmitted) {
      print('Level ');
      setState(() {
        isLevelOfCompletenessSubmitted = true;
      });
    } else if (isLevelOfCompletenessSubmitted &&
        isTagSubmitted &&
        _answerController.text.trim().isNotEmpty &&
        _titleController.text.trim().isNotEmpty) {
      answerWritingPromptBloc.add(
        CreateAnswerWritePromptEvent(
          answerWritePromptModel: AnswerWritePromptModel(
            question: widget.questionAnswerModel.question,
            sampleAnswer: widget.questionAnswerModel.sampleAnswer,
            answer: _answerController.text.trim(),
            title: _titleController.text.trim(),
            tags: tagList,
            levelOfCompleteness: levelOfCompleteness,
            degreeOfNotSucking: degreeOfSucking,
          ),
        ),
      );
      /*CustomDialogs.showSavingDataDialog(
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
      );*/
    } else {
      return;
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
