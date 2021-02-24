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

  TextComponent({
    @required this.title,
    this.color = Colors.black,
    this.fontSize = 18,
    this.fontWeight = FontWeight.bold,
    this.textAlign: TextAlign.left,
    this.margin: EdgeInsets.zero,
    this.alignment: Alignment.centerLeft,
    this.textOverflow: TextOverflow.fade,
    this.fontFamily,
    this.fontStyle,
    this.key,
    this.height,
    this.textDecoration,
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
        semanticsLabel: this.title,
        textAlign: textAlign,
        style: TextStyle(
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
