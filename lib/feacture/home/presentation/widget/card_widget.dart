import 'package:comedy/utils/component/text_component.dart';
import 'package:comedy/utils/style_util.dart';
import 'package:flutter/material.dart';

class HomeCardItem extends StatelessWidget {
  final String title;
  final String subTitle;
  final String icon;
  final VoidCallback cardClickCallback;
  final Color cardColor;
  final Color bgCardColor;

  const HomeCardItem({
    Key key,
    this.title,
    this.subTitle,
    this.icon,
    this.cardClickCallback,
    this.cardColor,
    this.bgCardColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: cardClickCallback,
      child: Container(
        height: MediaQuery.of(context).size.height/6,
        width: double.infinity,
        margin: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: bgCardColor,
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextComponent(
                    title: title,
                    textStyle: StyleUtil.levelOfCompletenessTextStyle,
                    margin: EdgeInsets.symmetric(vertical: 10),
                  ),
                  Expanded(
                    child: TextComponent(
                      title: subTitle,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.black38,
                      maxLine: MediaQuery.of(context).devicePixelRatio >= 1.6 ? 3 : 2,
                      textOverflow: TextOverflow.ellipsis,
                      margin: EdgeInsets.only(bottom: 8),
                    ),
                  ),
                ],
              ),
            ),
            Image.asset(
              icon,
              height: 74,
            ),
          ],
        ),
      ),
    );
  }
}
