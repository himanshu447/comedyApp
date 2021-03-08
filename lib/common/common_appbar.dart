import 'package:comedy/utils/component/text_component.dart';
import 'package:comedy/utils/icons_utils.dart';
import 'package:comedy/utils/style_util.dart';
import 'package:flutter/material.dart';

import 'general_widget.dart';
import 'package:comedy/common/general_widget.dart';
import 'package:comedy/utils/color_util.dart';
import 'package:comedy/utils/component/text_component.dart';
import 'package:comedy/utils/icons_utils.dart';
import 'package:comedy/utils/style_util.dart';
import 'package:flutter/material.dart';

Widget customAppbar(
    {bool isLeading = true,
    Color backgroundColor,
    String title,
    BuildContext context}) {
  return AppBar(
    centerTitle: true,
    automaticallyImplyLeading: false,
    leading: isLeading
        ? IconButton(
            icon: imageAsset(img: AppIcons.ic_back, width: 25.0, height: 25.0),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        : Container(),
    title: TextComponent(
      title: title,
      textStyle: StyleUtil.appBarTextStyle,
    ),
    backgroundColor: backgroundColor,
  );
}

