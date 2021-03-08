import 'package:comedy/common/general_widget.dart';
import 'package:comedy/utils/color_util.dart';
import 'package:comedy/utils/component/text_component.dart';
import 'package:comedy/utils/icons_utils.dart';
import 'package:comedy/utils/style_util.dart';
import 'package:flutter/material.dart';

class SubModuleAppBarWidget extends StatelessWidget {
  final Color color;
  final String title;
  final Widget actionWidget;
  final TextStyle titleTextStyle;
  final Color backIconColor;

  const SubModuleAppBarWidget({
    this.color,
    this.title,
    this.actionWidget,
    this.titleTextStyle,
    this.backIconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: color,
      padding: EdgeInsets.only(top: AppBar().preferredSize.height),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        dense: false,
        leading: IconButton(
          icon: imageAsset(
            img: AppIcons.ic_back,
            width: 25.0,
            height: 25.0,
            color: backIconColor ?? AppColor.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: TextComponent(
          title: title,
          textStyle: titleTextStyle ?? StyleUtil.appBarTextStyle,
          textAlign: TextAlign.center,
        ),
        trailing: actionWidget ??
            Container(
              width: 20,
            ),
      ),
    );
  }
}
