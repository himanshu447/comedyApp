import 'package:comedy/utils/color_util.dart';
import 'package:comedy/utils/component/text_component.dart';
import 'package:comedy/utils/string_util.dart';
import 'package:comedy/utils/style_util.dart';
import 'package:flutter/material.dart';

class CustomDialogs {
  static showSavingDataDialog({
    BuildContext context,
    String title,
  }) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: AppColor.white,
        contentPadding: EdgeInsets.all(30),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            TextComponent(
              title: title,
              textStyle: StyleUtil.formFieldTextStyle,
              margin: EdgeInsets.only(top: 22),
            ),
          ],
        ),
      ),
    );
  }

  static showConfirmDeletePromptDialog({
    BuildContext context,
    VoidCallback deleteCallback,
  }) {
    showDialog(
      context: context,
      builder: (_) =>  AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: AppColor.white,
        contentPadding: EdgeInsets.zero,
        title: TextComponent(
          title: AppString.delete_prompt_dialog_title,
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
                        deleteCallback();
                      },
                      child: TextComponent(
                        title: AppString.delete,
                        textStyle: StyleUtil.calenderHeaderTextStyle.copyWith(
                          color: AppColor.error,
                        ),
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
