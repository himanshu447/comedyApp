import 'package:comedy/common/custom_round_image.dart';
import 'package:comedy/feacture/events_shows/data/model/event_show_model.dart';
import 'package:comedy/utils/color_util.dart';
import 'package:comedy/utils/component/text_component.dart';
import 'package:comedy/utils/helper/timer_helper.dart';
import 'package:comedy/utils/string_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyEventListTile extends StatelessWidget {
  final EventShowModel eventShowModel;
  final Function onTap;

  const MyEventListTile({
    this.eventShowModel,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    String date = DateFormat('MMM d h:mm a').format(eventShowModel.startDate);
    //var date = DateFormat.jm().parse(temop).toString();

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
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.16,
                    child: CustomRoundCornerImage(
                      bottomLeftCorner: 10.0,
                      bottomRightCorner: 0.0,
                      topRightCorner: 0.0,
                      topLeftCorner: 10.0,
                      placeholder: 'images/trip.jpeg',
                      image: eventShowModel.image,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextComponent(
                          title: date,
                          fontSize: 16,
                          margin: EdgeInsets.symmetric(vertical: 10),
                          fontWeight: FontWeight.w400,
                          color: AppColor.primary_pink[500],
                        ),
                        TextComponent(
                          title: eventShowModel.name,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                        TextComponent(
                          title: '${eventShowModel.cost}',
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

            if(eventShowModel.isExpire)
              Positioned(
              right: 0,
              top: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12,vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                  )
                ),
                child: TextComponent(
                    title : 'Expired',
                    color: AppColor.white,
                    fontSize: 10,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
