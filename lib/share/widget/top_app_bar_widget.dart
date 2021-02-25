import 'package:comedy/utils/color_util.dart';
import 'package:comedy/utils/component/text_component.dart';
import 'package:flutter/material.dart';

class TopAppBarWidget extends StatelessWidget {
  final String title;
  final String subTitle;

  TopAppBarWidget({
    @required this.title,
    this.subTitle,
  }) {
    assert(title != null);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 4,
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
            fontSize: 30,
            fontWeight: FontWeight.w600,
            color: AppColor.white,
            textAlign: TextAlign.center,
          ),
          Visibility(
            visible: subTitle != null,
            child: TextComponent(
              title: subTitle != null ? subTitle : '',
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: AppColor.white,
              textAlign: TextAlign.center,
              margin: EdgeInsets.only(top: 60,right: 20,left: 20),
            ),
          )
        ],
      ),
    );
  }
}
