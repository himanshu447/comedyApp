import 'package:comedy/utils/color_util.dart';
import 'package:comedy/utils/component/text_component.dart';
import 'package:comedy/utils/string_util.dart';
import 'package:comedy/utils/style_util.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AutoFilledDateWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
              title: DateFormat('dd MMM,yyyy').format(DateTime.now()),
              textStyle: StyleUtil.formFieldTextStyle,
              textAlign: TextAlign.right,
            ),
          )
        ],
      ),
    );
  }
}
