import 'package:comedy/utils/color_util.dart';
import 'package:flutter/material.dart';

class TextComponent extends StatelessWidget {
  final Color color;
  final String title;
  final double fontSize;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final EdgeInsets margin;
  final Alignment alignment;
  final TextOverflow textOverflow;
  final String fontFamily;
  final FontStyle fontStyle;
  final Key key;
  final double height;
  final TextDecoration textDecoration;
  final int maxLine;
  final TextStyle textStyle;

  TextComponent({
    @required this.title,
    this.color = AppColor.black,
    this.fontSize = 18,
    this.fontWeight = FontWeight.bold,
    this.textAlign: TextAlign.left,
    this.margin: EdgeInsets.zero,
    this.alignment: Alignment.centerLeft,
    this.textOverflow: TextOverflow.fade,
    this.fontFamily = 'SF Pro Display',
    this.fontStyle,
    this.key,
    this.height,
    this.textStyle,
    this.textDecoration,
    this.maxLine,
  }) {
    assert(title != null);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: this.margin,
      child: Text(
        this.title,
        key: key,
        maxLines: maxLine,
        semanticsLabel: this.title,
        textAlign: textAlign,
        style: textStyle ??
            TextStyle(
              decoration: textDecoration,
              fontFamily: fontFamily,
              color: this.color,
              fontWeight: this.fontWeight,
              fontSize: this.fontSize,
              fontStyle: fontStyle,
              height: height,
            ),
        overflow: textOverflow,
      ),
    );
  }
}
