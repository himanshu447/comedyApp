import 'package:comedy/utils/screen_utils.dart';
import 'package:flutter/material.dart';

Widget horizontalSpace(double width) => SizedBox(width: width);

Widget verticalSpace(double height) => SizedBox(height: height);

Widget verticalColorBar() => Container(
      height: height * 0.03,
      width: width,
      decoration: BoxDecoration(),
    );

Widget imageAsset({String img, double width, double height, Color color}) =>
    Container(
      child: Image.asset(
        img,
        width: width,
        height: height,
        color: color,
        fit: BoxFit.cover,
      ),
    );
