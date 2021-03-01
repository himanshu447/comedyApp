import 'package:comedy/utils/color_util.dart';
import 'package:comedy/utils/component/text_component.dart';
import 'package:flutter/material.dart';

class ShowAddWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      left: 0.0,
      right: 0.0,
      child: Container(
        height: 50,
        color: AppColor.gry,
        alignment: Alignment.center,
        child: TextComponent(
          title: 'Ads',
          color: AppColor.white,
        ),
      ),
    );
  }
}
