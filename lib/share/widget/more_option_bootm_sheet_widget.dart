import 'package:comedy/utils/color_util.dart';
import 'package:comedy/utils/component/text_component.dart';
import 'package:comedy/utils/string_util.dart';
import 'package:comedy/utils/style_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MoreOptionBottomSheetWidget {
  final Color cancelButtonColor;
  final VoidCallback editButtonCallback;
  final VoidCallback deleteButtonCallback;
  final VoidCallback shareButtonCallback;

  MoreOptionBottomSheetWidget({
    this.cancelButtonColor,
    this.editButtonCallback,
    this.deleteButtonCallback,
    this.shareButtonCallback,
  });

  showMoreSheetDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColor.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 50,
                child: Divider(
                  thickness: 3,
                  color: AppColor.bottomBarTextColor,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                  editButtonCallback();
                },
                child: TextComponent(
                  title: AppString.edit,
                  textStyle: StyleUtil.calenderHeaderTextStyle,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                  deleteButtonCallback();
                },
                child: TextComponent(
                  title: AppString.delete,
                  textStyle: StyleUtil.calenderHeaderTextStyle,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                  shareButtonCallback();
                },
                child: TextComponent(
                  title: AppString.share,
                  textStyle: StyleUtil.calenderHeaderTextStyle,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              RawMaterialButton(
                constraints: BoxConstraints(
                  maxWidth: double.infinity,
                  minWidth: double.infinity,
                ),
                onPressed: () => Navigator.pop(context),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(color: cancelButtonColor, width: 2)),
                padding: EdgeInsets.symmetric(vertical: 18),
                child: TextComponent(
                  title: AppString.cancel,
                  textStyle: StyleUtil.nextButtonTextStyle.copyWith(
                    color: cancelButtonColor,
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
