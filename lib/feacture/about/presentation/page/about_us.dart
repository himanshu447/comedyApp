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
            title:
                "Do you have an interest in comedy writing, but have no idea where to get started? Or are you already a comedy writer or comedian who wants to keep track of your writing? No matter who you are in the comedy arena, LaughDraft is for you!",
            textStyle: StyleUtil.calenderHeaderTextStyle,
            margin: EdgeInsets.symmetric(horizontal: 16),
          ),
          TextComponent(
            title:
                "This app lets you write on your own, or follow carefully-crafted prompts to bring out your funny bone. Bonus – discover (or advertise) new comedy events and shows!",
            textStyle: StyleUtil.calenderHeaderTextStyle,
            margin: EdgeInsets.symmetric(horizontal: 16,vertical: 20),
          ),
        ],
      ),
    );
  }
}
