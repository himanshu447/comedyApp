import 'package:comedy/share/widget/sub_module_app_bar_widget.dart';
import 'package:comedy/utils/color_util.dart';
import 'package:comedy/utils/component/text_component.dart';
import 'package:comedy/utils/string_util.dart';
import 'package:comedy/utils/style_util.dart';
import 'package:flutter/material.dart';

class AboutUsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SubModuleAppBarWidget(
            color: AppColor.primary_blue[500],
            title: AppString.about,
            titleTextStyle: StyleUtil.appBarTextStyle.copyWith(
              color: AppColor.white,
            ),
            backIconColor: AppColor.white,
            actionWidget: Container(
              width: 50,
            ),
          ),
          SizedBox(
            height: 100,
          ),
          TextComponent(
            title: 'About US',
          ),
        ],
      ),
    );
  }
}
