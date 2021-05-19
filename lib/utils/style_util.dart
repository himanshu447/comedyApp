import 'package:comedy/utils/color_util.dart';
import 'package:flutter/material.dart';

class StyleUtil {
  static TextStyle bottomTabTextStyle = const TextStyle(
    fontSize: 10,
    color: AppColor.bottomBarTextColor,
    fontWeight: FontWeight.w500,
    fontFamily: 'SF Pro Display',
    height: 1.8,
  );

  static TextStyle appBarTextStyle = const TextStyle(
    fontSize: 28,
    color: AppColor.black,
    fontWeight: FontWeight.w600,
    fontFamily: 'SF Pro Display',
  );

  static TextStyle formFieldTextStyle = const TextStyle(
    fontSize: 17,
    color: AppColor.black,
    fontWeight: FontWeight.w400,
    fontFamily: 'SF Pro Display',
  );
  static TextStyle calenderBodyTextStyle = const TextStyle(
    fontSize: 17,
    color: AppColor.white,
    fontWeight: FontWeight.w400,
    fontFamily: 'SF Pro Display',
  );
  static TextStyle calenderTextStyle = const TextStyle(
    fontSize: 17,
    color: AppColor.gry,
    fontWeight: FontWeight.w400,
    fontFamily: 'SF Pro Display',
  );
  static TextStyle calenderHeaderTextStyle = const TextStyle(
    fontSize: 17,
    color: AppColor.black,
    fontWeight: FontWeight.w600,
    fontFamily: 'SF Pro Display',
  );

  static TextStyle titleHeaderTextStyle = const TextStyle(
    fontSize: 20,
    color: AppColor.black,
    fontWeight: FontWeight.w600,
    fontFamily: 'SF Pro Display',
  );

  static TextStyle activeNumberTextStyle = TextStyle(
    fontSize: 37,
    fontWeight: FontWeight.w600,
    fontFamily: 'SF Pro Display',
    color: AppColor.primary_orange[500],
  );

  static TextStyle inActiveNumberTextStyle = const TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.w600,
    fontFamily: 'SF Pro Display',
    color: AppColor.gry,
  );

  static TextStyle activeNumberTextStyleForDetail = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w600,
    fontFamily: 'SF Pro Display',
    color: AppColor.primary_orange[500],
  );


  static TextStyle levelOfCompletenessTextStyle = const TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    fontFamily: 'SF Pro Display',
    color: AppColor.black,
  );

  static TextStyle nextButtonTextStyle = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    fontFamily: 'SF Pro Display',
    color: AppColor.white,
  );

  static TextStyle topAppBarTextStyle = const TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w400,
    fontFamily: 'RubikMonoOne',
    color: AppColor.white,
  );

}
