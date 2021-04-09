import 'package:comedy/feacture/my_saved/data/model/my_saved_model.dart';
import 'package:comedy/utils/color_util.dart';
import 'package:comedy/utils/component/text_component.dart';
import 'package:comedy/utils/icons_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MySavedItem extends StatelessWidget {
  final MySavedModel mySavedModel;

  const MySavedItem({this.mySavedModel});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      color: AppColor.white,
      shadowColor: AppColor.gry,
      margin: EdgeInsets.only(bottom: 30),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.circular(15)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextComponent(
              title: mySavedModel.title,
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
                  title:
                      DateFormat('dd MMM, yyyy').format(mySavedModel.createdAt),
                  fontWeight: FontWeight.w400,
                  fontSize: 17,
                  color: AppColor.gry,
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 14),
                ),
              ],
            ),
            TextComponent(
              title: mySavedModel.answer != null
                  ? mySavedModel.answer
                  : mySavedModel.withoutPromptDescription,
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
