import 'package:comedy/feacture/my_saved/data/model/my_saved_model.dart';
import 'package:comedy/utils/color_util.dart';
import 'package:comedy/utils/component/text_component.dart';
import 'package:comedy/utils/icons_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MySavedItem extends StatelessWidget {
  final MySavedModel mySavedModel;

  const MySavedItem({this.mySavedModel});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      color: AppColor.white,
      shadowColor: AppColor.gry,
      margin: EdgeInsets.symmetric(vertical: 20),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.circular(15)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextComponent(
              title: 'Prompts Writing #1',
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
            Row(
              children: [
                Image.asset(
                  AppIcons.ic_calendar,
                  height: 20,
                  width: 20,
                ),
                TextComponent(
                  title: '30 Jan, 2021',
                  fontWeight: FontWeight.w400,
                  fontSize: 17,
                  color: AppColor.gry,
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 14),
                ),
              ],
            ),
            TextComponent(
              title:
                  'Now led tedious shy lasting females off. Dashwood marianne in of enterance be...',
              fontSize: 17,
              fontWeight: FontWeight.w400,
              textOverflow: TextOverflow.ellipsis,
              maxLine: 2,
            ),
          ],
        ),
      ),
    );
  }
}
