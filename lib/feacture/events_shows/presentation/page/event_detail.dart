import 'package:comedy/common/custom_round_image.dart';
import 'package:comedy/common/general_widget.dart';
import 'package:comedy/utils/color_util.dart';
import 'package:comedy/utils/component/text_component.dart';
import 'package:comedy/utils/icons_utils.dart';
import 'package:flutter/material.dart';

class EventDetail extends StatefulWidget {
  @override
  _EventDetailState createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                CustomRoundCornerImage(
                  bottomLeftCorner: 0.0,
                  bottomRightCorner: 0.0,
                  topRightCorner: 0.0,
                  topLeftCorner: 0.0,
                  placeholder: 'images/trip.jpeg',
                  image: ' ',
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 3,
                ),
                Positioned(
                  left: 0,
                  top: 50  ,
                  child: IconButton(
                      onPressed: () {},
                      color: AppColor.white ,
                      padding: EdgeInsets.all(4),
                      icon: imageAsset(
                          img: AppIcons.ic_back, width: 25.0, height: 25.0)),
                )
              ],
            ),
            TextComponent(
              title: 'Feb 7 AT 8:30 AM EST - Feb 7 AT 8:30 AM EST',
              fontSize: 16,
              margin: EdgeInsets.symmetric(vertical: 10),
              fontWeight: FontWeight.w400,
              color: AppColor.primary_pink[500],
            ),

            TextComponent(
              title: 'Mardi Gras (New Orleans, Louisiana)',
              fontSize: 22,
              margin: EdgeInsets.symmetric(vertical: 10),
              fontWeight: FontWeight.w600,
              color: AppColor.black,
            ),


          ],
        ),
      ),
    );
  }
}
