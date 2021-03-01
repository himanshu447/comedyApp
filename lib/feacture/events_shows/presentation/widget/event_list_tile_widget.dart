import 'package:comedy/common/custom_round_image.dart';
import 'package:comedy/utils/color_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyEventListTile extends StatelessWidget {
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: CustomRoundCornerImage(
                image:
                    'data:image/jpeg;base64,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',
                width: 100,
              ),
            )
          ],
        ),
      ),
    );
  }
}
