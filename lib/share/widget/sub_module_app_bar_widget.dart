import 'package:comedy/common/general_widget.dart';
import 'package:comedy/utils/component/text_component.dart';
import 'package:comedy/utils/icons_utils.dart';
import 'package:comedy/utils/style_util.dart';
import 'package:flutter/material.dart';

class SubModuleAppBarWidget extends StatelessWidget {
  final Color color;
  final String title;
  final Widget actionWidget;

  const SubModuleAppBarWidget({
    this.color,
    this.title,
    this.actionWidget,
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
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: TextComponent(
          title: title,
          textStyle: StyleUtil.appBarTextStyle,
          fontSize: 28,
          fontWeight: FontWeight.w600,
          textAlign: TextAlign.center,
        ),
        trailing: actionWidget,
      ),
    );
  }
}
