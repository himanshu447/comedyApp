import 'package:comedy/utils/color_util.dart';
import 'package:comedy/utils/component/text_component.dart';
import 'package:comedy/utils/string_util.dart';
import 'package:comedy/utils/style_util.dart';
import 'package:flutter/material.dart';

class LevelAndDegreeDetailWidget extends StatelessWidget {
  final int levelOfCompleteness;
  final int degreeOfSucking;

  const LevelAndDegreeDetailWidget({
    @required this.levelOfCompleteness,
    @required this.degreeOfSucking,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        color: AppColor.textFieldBgColor,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 22),
        child: ListBody(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextComponent(
                  title: AppString.level_of_completeness,
                  textStyle: StyleUtil.formFieldTextStyle,
                ),
                TextComponent(
                  title: levelOfCompleteness.toString(),
                  textStyle: StyleUtil.formFieldTextStyle,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextComponent(
                  title: AppString.degree_of_not_sucking,
                  textStyle: StyleUtil.formFieldTextStyle,
                ),
                TextComponent(
                  title: degreeOfSucking.toString(),
                  textStyle: StyleUtil.formFieldTextStyle,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
