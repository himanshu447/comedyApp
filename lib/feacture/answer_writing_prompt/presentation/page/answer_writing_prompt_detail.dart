import 'package:comedy/feacture/answer_writing_prompt/data/model/answer_write_prompt_model.dart';
import 'package:comedy/feacture/answer_writing_prompt/presentation/bloc/answer_writing_prompt_bloc.dart';
import 'package:comedy/share/widget/auto_filled_date_widget.dart';
import 'package:comedy/share/widget/custom_dialog_widget.dart';
import 'package:comedy/share/widget/level_and_degree_detail_widget.dart';
import 'package:comedy/share/widget/more_option_bootm_sheet_widget.dart';
import 'package:comedy/share/widget/sub_module_app_bar_widget.dart';
import 'package:comedy/utils/color_util.dart';
import 'package:comedy/utils/component/input-chip.component.dart';
import 'package:comedy/utils/component/size_config.dart';
import 'package:comedy/utils/component/text_component.dart';
import 'package:comedy/utils/icons_utils.dart';
import 'package:comedy/utils/string_util.dart';
import 'package:comedy/utils/style_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share/share.dart';

class AnswerWritingPromptDetailView extends StatefulWidget {
  final AnswerWritePromptModel answerWritePromptModel;

  const AnswerWritingPromptDetailView({this.answerWritePromptModel});

  @override
  _AnswerWritingPromptDetailViewState createState() =>
      _AnswerWritingPromptDetailViewState();
}

class _AnswerWritingPromptDetailViewState
    extends State<AnswerWritingPromptDetailView> {
  TextEditingController _titleController;
  TextEditingController _promptController;

  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _promptFocusNode = FocusNode();

  final GlobalKey<FormState> _answerDetailFormKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  List<String> tagList = [];

  bool isEditButtonPress = false;

  AnswerWritingPromptBloc answerWritingPromptBloc;

  @override
  void initState() {
    _titleController = TextEditingController(
      text: widget.answerWritePromptModel.title,
    );
    _promptController = TextEditingController(
      text: widget.answerWritePromptModel.answer,
    );

    if (widget.answerWritePromptModel.tags.isNotEmpty) {
      tagList = widget.answerWritePromptModel.tags;
    }

    super.initState();
  }

  @override
  void didChangeDependencies() {
    answerWritingPromptBloc = BlocProvider.of<AnswerWritingPromptBloc>(context, listen: true);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    answerWritingPromptBloc.add(LoadQuestionsEvent());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: BlocListener(
        cubit: answerWritingPromptBloc,
        listener: (_, state) {
          if (state is DeletedAnswerWritingPromptState) {
            Navigator.pop(context);
          } else if (state is AnswerWritingPromptSubmittingState) {
            CustomDialogs.showSavingDataDialog(
              context: context,
              title: AppString.saving_your_writing,
            );
          } else if (state is AnswerWritingPromptSuccessState) {
            Navigator.pop(context);
            setState(() {
              isEditButtonPress = false;
            });
          } else if (state is ErrorState) {
            showSnackBar(msg: state.error);
          }
        },
        child: BlocBuilder<AnswerWritingPromptBloc, AnswerWritingPromptState>(
          cubit: answerWritingPromptBloc,
          builder: (_, state) {
            if (state is DeletingAnswerWritingPromptState) {
              return _loadBody(isDataDeleting: true);
            }
            return _loadBody();
          },
        ),
      ),
    );
  }

  Widget _loadBody({bool isDataDeleting = false}) {
    return Stack(
      fit: StackFit.expand,
      children: [
        SingleChildScrollView(
          padding: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical * 50),
          child: Form(
            key: _answerDetailFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SubModuleAppBarWidget(
                  color: AppColor.primary_green[500],
                  title: AppString.write_prompt,
                  actionWidget: isEditButtonPress
                      ? FlatButton(
                          onPressed: () {
                            answerWritingPromptBloc.add(
                              UpdateAnswerWritingPromptEvent(
                                answerWritePromptModel:
                                AnswerWritePromptModel(
                                  id: widget.answerWritePromptModel.id,
                                  answer: _promptController.text.trim(),
                                  title: _titleController.text.trim(),
                                  sampleAnswer: widget.answerWritePromptModel.sampleAnswer,
                                  question: widget.answerWritePromptModel.question,
                                  updatedAt: DateTime.now(),
                                  tags: tagList,
                                  levelOfCompleteness: widget.answerWritePromptModel.levelOfCompleteness,
                                  degreeOfNotSucking: widget.answerWritePromptModel.degreeOfNotSucking,
                                ),
                              ),
                            );
                          },
                          child: TextComponent(
                            title: AppString.save,
                            textStyle: StyleUtil.calenderHeaderTextStyle,
                          ),
                        )
                      : IconButton(
                          icon: Image.asset(
                            AppIcons.ic_more,
                            height: 20,
                          ),
                          onPressed: _showMoreBottomSheet,
                        ),
                ),
                AutoFilledDateWidget(),
                isEditButtonPress
                    ? Padding(
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
                      )
                    : TextComponent(
                        title: _titleController.text.trim(),
                        textStyle: StyleUtil.calenderHeaderTextStyle,
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      ),
                isEditButtonPress
                    ? Padding(
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
                      )
                    : TextComponent(
                        title: _promptController.text.trim(),
                        textStyle: StyleUtil.formFieldTextStyle,
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      ),
                widget.answerWritePromptModel.tags.isNotEmpty
                    ? InputChipComponent(
                        list: tagList,
                        hintText: AppString.hint_prompt_has_tag,
                        chipColor: AppColor.primary_green[100],
                        chipTextColor: AppColor.primary_green[500],
                        keyboardType: TextInputType.text,
                        isTextFieldVisible: isEditButtonPress,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ).copyWith(top: 14, bottom: 14),
                        onAddCallBack: (val) {
                          setState(() {
                            tagList.add('#${val.trim()}');
                          });
                        },
                      )
                    : Container()
              ],
            ),
          ),
        ),

        //bottom Level And Degree
        MediaQuery.of(context).viewInsets.bottom == 0
            ? LevelAndDegreeDetailWidget(
                levelOfCompleteness:
                    widget.answerWritePromptModel.levelOfCompleteness,
                degreeOfSucking:
                    widget.answerWritePromptModel.degreeOfNotSucking,
              )
            : Container(),

        isDataDeleting
            ? Positioned(
                top: 0,
                bottom: 0,
                left: 0,
                right: 0,
                child:  Container(
                  color: Colors.black12,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }

  _showMoreBottomSheet() {
    MoreOptionBottomSheetWidget(
      cancelButtonColor: AppColor.primary_orange[500],
      deleteButtonCallback: () {
        CustomDialogs.showConfirmDeletePromptDialog(
          context: context,
          deleteCallback: () {
            try {
              answerWritingPromptBloc.add(
                DeleteAnswerWritingPromptEvent(
                  id: widget.answerWritePromptModel.id,
                ),
              );
            } catch (e) {
              print(e.toString());
            }
          },
        );
      },
      editButtonCallback: () {
        setState(() {
          isEditButtonPress = true;
        });
      },
      shareButtonCallback: () {
        Share.share('this is share button');
      },
    ).showMoreSheetDialog(context);
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
