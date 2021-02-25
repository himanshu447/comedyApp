import 'package:comedy/utils/color_util.dart';
import 'package:comedy/utils/component/text_component.dart';
import 'package:comedy/utils/string_util.dart';
import 'package:flutter/material.dart';

class HomeWriteWithoutPromptCardWidget extends StatelessWidget {
  final VoidCallback cardClickCallback;

  const HomeWriteWithoutPromptCardWidget({this.cardClickCallback});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: cardClickCallback,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 12,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: AppColor.primary_orange[500],
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: AppColor.primary_orange[400],
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
                    title: AppString.write_without_prompts,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: AppColor.black,
                    margin: EdgeInsets.symmetric(vertical: 10),
                  ),
                  TextComponent(
                    title: AppString.write_without_prompts_desc,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black38,
                  ),
                ],
              ),
            ),
            Image.asset(
              'assets/images/icons/home/wire_without_prompts.png',
              height: 74,
            ),
          ],
        ),
      ),
    );
  }
}
