import 'package:comedy/common/general_widget.dart';
import 'package:comedy/utils/color_util.dart';
import 'package:comedy/utils/component/input-chip.component.dart';
import 'package:comedy/utils/component/number_selection_swiper.dart';
import 'package:comedy/utils/component/number_slider_component.dart';
import 'package:comedy/utils/component/text_component.dart';
import 'package:comedy/utils/icons_utils.dart';
import 'package:comedy/utils/string_util.dart';
import 'package:comedy/utils/style_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:numberpicker/numberpicker.dart';

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

  List<String> secondList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loadBody(),
    );
  }

  Widget _loadBody() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
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
                trailing: FlatButton(
                  onPressed: null,
                  child: TextComponent(
                    title: AppString.done,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Container(
              color: AppColor.textFieldBgColor,
              margin: EdgeInsets.only(bottom: 16),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 22),
              child: Row(
                children: [
                  TextComponent(
                    title: AppString.date,
                    textStyle: StyleUtil.formFieldTextStyle,
                  ),
                  TextComponent(
                    title: AppString.auto_filled,
                    textStyle: StyleUtil.calenderTextStyle,
                    margin: EdgeInsets.symmetric(horizontal: 12),
                  ),
                  Expanded(
                    child: TextComponent(
                      title: '01 Feb, 2021',
                      textStyle: StyleUtil.formFieldTextStyle,
                      textAlign: TextAlign.right,
                    ),
                  )
                ],
              ),
            ),
            isPromptTitleAndDescSubmitted
                ? TextComponent(
                    title: _titleController.text.trim(),
                    textStyle: StyleUtil.calenderHeaderTextStyle,
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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
                          FocusScope.of(context).requestFocus(_titleFocusNode);
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
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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
                          FocusScope.of(context).requestFocus(_promptFocusNode);
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
                    list: secondList,
                    hintText: AppString.hint_prompt_has_tag,
                    chipColor: AppColor.primary_orange[100],
                    chipTextColor: AppColor.primary_orange[500],
                    keyboardType: TextInputType.text,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 10)
                            .copyWith(top: 14),
                    onAddCallBack: (val) {
                      setState(() {
                        secondList.add(val.trim());
                      });
                    },
                  )
                : Container(),

            HorizantalPicker(
              minValue: 1,
              maxValue: 10,
              onChanged: (val) {},
              activeItemBgColor: AppColor.primary_orange[100],
              activeTextStyle: StyleUtil.activeNumberTextStyle,
              deActiveTextStyle: StyleUtil.inActiveNumberTextStyle,
            ),
            RawMaterialButton(
              onPressed: _submitPromptTitleAndDesc,
              fillColor: AppColor.primary_orange[500],
              child: TextComponent(
                title: AppString.next,
              ),
            )
          ],
        ),
      ),
    );
  }

  _submitPromptTitleAndDesc() {
    if (_formKey.currentState.validate()) {
      setState(() {
        isPromptTitleAndDescSubmitted = true;
      });
    }
  }
}
