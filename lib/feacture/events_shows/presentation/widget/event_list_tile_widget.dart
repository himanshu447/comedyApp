import 'package:comedy/common/custom_round_image.dart';
import 'package:comedy/utils/color_util.dart';
import 'package:comedy/utils/component/text_component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyEventListTile extends StatelessWidget {
  final String eventTime, eventTitle, eventOPrice;
  final Function onTap;

  const MyEventListTile(
      {this.eventTime, this.onTap, this.eventTitle, this.eventOPrice});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 1,
        color: AppColor.white,
        shadowColor: AppColor.gry,
        margin: EdgeInsets.symmetric(vertical: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomRoundCornerImage(
                bottomLeftCorner: 10.0,
                bottomRightCorner: 0.0,
                topRightCorner: 0.0,
                topLeftCorner: 10.0,
                placeholder: 'images/trip.jpeg',
                image: ' ',
                width: 150,
                height: 120,
              ),
              /*       Image.asset(
                'assets/images/trip.jpeg',
                width: 150,
                fit: BoxFit.cover,
              ),*/
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextComponent(
                        title: eventTime,
                        fontSize: 16,
                        margin: EdgeInsets.symmetric(vertical: 10),
                        fontWeight: FontWeight.w400,
                        color: AppColor.primary_pink[500],
                      ),
                      TextComponent(
                        title: eventTitle,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                      TextComponent(
                        title: eventOPrice,
                        fontSize: 16,
                        margin: EdgeInsets.symmetric(vertical: 10),
                        fontWeight: FontWeight.w400,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
