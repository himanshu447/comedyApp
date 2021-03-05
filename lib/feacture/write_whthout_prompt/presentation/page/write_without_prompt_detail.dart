import 'package:comedy/feacture/write_whthout_prompt/data/model/write_without_prompt_model.dart';
import 'package:comedy/share/widget/auto_filled_date_widget.dart';
import 'package:comedy/share/widget/level_and_degree_detail_widget.dart';
import 'package:comedy/share/widget/more_option_bootm_sheet_widget.dart';
import 'package:comedy/share/widget/custom_dialog_widget.dart';
import 'package:comedy/share/widget/sub_module_app_bar_widget.dart';
import 'package:comedy/utils/color_util.dart';
import 'package:comedy/utils/component/input-chip.component.dart';
import 'package:comedy/utils/component/text_component.dart';
import 'package:comedy/utils/icons_utils.dart';
import 'package:comedy/utils/string_util.dart';
import 'package:comedy/utils/style_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

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
  TextEditingController _titleController;
  TextEditingController _promptController;

  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _promptFocusNode = FocusNode();

  final GlobalKey<FormState> _detailFormKey = GlobalKey<FormState>();

  List<String> tagList = [];

  bool isEditButtonPress = false;

  @override
  void initState() {
    _titleController = TextEditingController(
      text: widget.withoutPromptModel.title,
    );
    _promptController = TextEditingController(
      text: widget.withoutPromptModel.description,
    );

    if (widget.withoutPromptModel.tags.isNotEmpty) {
      tagList = widget.withoutPromptModel.tags;
    }
    super.initState();
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
            key: _detailFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SubModuleAppBarWidget(
                  color: AppColor.primary_orange[500],
                  title: AppString.free_write,
                  actionWidget: isEditButtonPress
                      ? FlatButton(
                          onPressed: (){
                            setState(() {
                              isEditButtonPress = false;
                            });
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
                widget.withoutPromptModel.tags.isNotEmpty
                    ? InputChipComponent(
                        list: tagList,
                        hintText: AppString.hint_prompt_has_tag,
                        chipColor: AppColor.primary_orange[100],
                        chipTextColor: AppColor.primary_orange[500],
                        keyboardType: TextInputType.text,
                        isTextFieldVisible: isEditButtonPress,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ).copyWith(top: 14, bottom: 14),
                        onAddCallBack: (val) {
                          setState(() {
                            tagList.add(val.trim());
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
                    widget.withoutPromptModel.levelOfCompleteness,
                degreeOfSucking: widget.withoutPromptModel.degreeOfSucking,
              )
            : Container(),
      ],
    );
  }

  _showMoreBottomSheet() {
    MoreOptionBottomSheetWidget(
        cancelButtonColor: AppColor.primary_orange[500],
        deleteButtonCallback: () {
          print('show delete dialog');
          CustomDialogs.showConfirmDeletePromptDialog(
            context: context,
            deleteCallback: () {
              print('delete button press from dialog');
            },
          );
        },
        editButtonCallback: () {
          print('Edit button press');
          setState(() {
            isEditButtonPress = true;
          });
        },
        shareButtonCallback: () {
          print('Share button press');
          Share.share('this is share button');
        }).showMoreSheetDialog(context);
  }
}
