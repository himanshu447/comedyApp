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
            height: 50,
          ),
          TextComponent(
            title: "LaughDraft caters to two types of users: those who have an interest in comedy writing, but don't have the confidence or know-how on where to start, and those who are already comedy writers or comedians and who want to keep track of their writing. We provide the ability to write, as well as to discover new comedy events and shows.",
            textStyle: StyleUtil.calenderHeaderTextStyle,
            margin: EdgeInsets.symmetric(horizontal: 16),
          ),
        ],
      ),
    );
  }
}
