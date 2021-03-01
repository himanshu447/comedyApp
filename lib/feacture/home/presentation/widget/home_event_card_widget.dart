import 'package:comedy/utils/color_util.dart';
import 'package:comedy/utils/component/text_component.dart';
import 'package:comedy/utils/icons_utils.dart';
import 'package:comedy/utils/string_util.dart';
import 'package:flutter/material.dart';

class HomeEventCardWidget extends StatelessWidget {
  final VoidCallback cardClickCallback;

  const HomeEventCardWidget({this.cardClickCallback});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: cardClickCallback,
      child: Container(
        height: MediaQuery.of(context).size.width/3,
        margin: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: AppColor.primary_pink[500],
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: AppColor.primary_pink[400],
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
                    title: AppString.event_and_shows,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: AppColor.black,
                    margin: EdgeInsets.symmetric(vertical: 10),
                  ),
                  Expanded(
                    child: TextComponent(
                      title: AppString.event_and_shows_desc,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.black38,
                      maxLine: 3,
                      textOverflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            Image.asset(
              AppIcons.ic_home_event,
              alignment: Alignment.centerRight,
              height: 74,
            ),
          ],
        ),
      ),
    );
  }
}
