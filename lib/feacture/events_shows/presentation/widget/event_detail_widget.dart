import 'package:comedy/common/custom_round_image.dart';
import 'package:comedy/common/general_widget.dart';
import 'package:comedy/utils/color_util.dart';
import 'package:comedy/utils/component/text_component.dart';
import 'package:comedy/utils/icons_utils.dart';
import 'package:flutter/material.dart';

Widget eventTopWidget({BuildContext context, String imageUrl}) {
  return Stack(
    children: [
      CustomRoundCornerImage(
        bottomLeftCorner: 0.0,
        bottomRightCorner: 0.0,
        topRightCorner: 0.0,
        topLeftCorner: 0.0,
        placeholder: 'images/trip.jpeg',
        image: imageUrl,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 3,
      ),
      SafeArea(
        child: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            decoration:
                BoxDecoration(color: AppColor.white, shape: BoxShape.circle),
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: imageAsset(img: AppIcons.ic_back, width: 20.0, height: 20.0),
          ),
        ),
      )
    ],
  );
}

Widget eventScheduleDate(String title) {
  return TextComponent(
    title: title,
    fontSize: 16,
    margin: EdgeInsets.symmetric(vertical: 20),
    fontWeight: FontWeight.w400,
    color: AppColor.primary_pink[500],
  );
}

Widget eventTitle(String title) {
  return TextComponent(
    title: title,
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: AppColor.black,
  );
}
