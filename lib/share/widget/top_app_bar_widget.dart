import 'package:comedy/utils/color_util.dart';
import 'package:comedy/utils/component/text_component.dart';
import 'package:comedy/utils/style_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TopAppBarWidget extends StatelessWidget {
  final String title;
  final Widget subTitle;

   TopAppBarWidget({
    @required this.title,
    this.subTitle = const SizedBox(),
  }) {
    assert(title != null);
  }

  @override
  Widget build(BuildContext context) {

    final height = AppBar().preferredSize.height;

    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.width /1.39,
      padding: EdgeInsets.only(top: height+20),
      decoration: BoxDecoration(
        color: AppColor.primary_blue[500],
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
      ),
      child: Column(
        children: [
          TextComponent(
            title: title,
            textStyle: StyleUtil.topAppBarTextStyle,
          ),
          subTitle,
        ],
      ),
    );
  }
}
