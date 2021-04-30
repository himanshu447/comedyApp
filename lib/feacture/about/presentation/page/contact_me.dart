import 'package:comedy/share/widget/sub_module_app_bar_widget.dart';
import 'package:comedy/utils/color_util.dart';
import 'package:comedy/utils/component/text_component.dart';
import 'package:comedy/utils/string_util.dart';
import 'package:comedy/utils/style_util.dart';
import 'package:flutter/material.dart';

class ContactMeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SubModuleAppBarWidget(
            color: AppColor.primary_blue[500],
            title: 'Contact',
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
            title: "I'm Julie of The Flying Tings, LLC. I'm  a member of the Washington DC Comedy Writers Group, and got my inspiration for the app from their weekly writing exercises. I don't consider myself a comedian, but DO consider myself an aspiring comedy writer. ",
            textStyle: StyleUtil.calenderHeaderTextStyle,
            margin: EdgeInsets.symmetric(horizontal: 16),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text.rich(
              TextSpan(
                text: 'Check out the website at',
                style: StyleUtil.calenderHeaderTextStyle,
                children: [
                  TextSpan(
                    text: ' '
                        'www.laughdraft.com',
                    style: StyleUtil.calenderHeaderTextStyle.copyWith(color: Colors.blue),
                  ),

                  TextSpan(
                    text: ', and drop me a line at',
                    style: StyleUtil.calenderHeaderTextStyle,
                  ),
                  TextSpan(
                    text: ' julie@laughdraft.com.',
                    style: StyleUtil.calenderHeaderTextStyle.copyWith(color: Colors.blue),
                  ),
                ]
              ),
            ),
          ),
          /*TextComponent(
            title: "  ",
            textStyle: StyleUtil.calenderHeaderTextStyle,
            margin: EdgeInsets.symmetric(horizontal: 16),
          ),*/
        ],
      ),
    );
  }
}
