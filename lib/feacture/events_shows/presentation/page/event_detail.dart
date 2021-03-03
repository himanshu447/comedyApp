import 'package:comedy/common/custom_round_image.dart';
import 'package:comedy/common/general_widget.dart';
import 'package:comedy/feacture/events_shows/presentation/widget/event_detail_widget.dart';
import 'package:comedy/utils/color_util.dart';
import 'package:comedy/utils/component/text_component.dart';
import 'package:comedy/utils/icons_utils.dart';
import 'package:comedy/utils/string_util.dart';
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
            eventTopWidget(context: context, imageUrl: ' '),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  eventScheduleDate(
                      'Feb 7 AT 8:30 AM EST - Feb 7 AT 8:30 AM EST'),
                  eventTitle('Mardi Gras (New Orleans, Louisiana)'),
                  verticalSpace(20),
                  descriptionTile(title: '\$151', iconName: AppIcons.ic_ticket),
                  verticalSpace(20),
                  descriptionTile(
                      title: 'www.facebook.com', iconName: AppIcons.ic_web),
                  verticalSpace(20),
                  Divider(
                    color: AppColor.verticalDividerColor,
                    height: 2,
                  ),
                  verticalSpace(20),
                  TextComponent(
                    title: AppString.details,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                  verticalSpace(15),
                  TextComponent(
                    title:
                        'Mardi Gras is a wonderful carnival that takes place in New Orleans each year. The festival can be traced back to medieval Europe. It was brought to America by the French-Canadian explorer Jean Baptiste Le Moyne Sieur de Bienville.',
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                  ),
                  verticalSpace(15),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget descriptionTile({String title, iconName}) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
              color: AppColor.textFieldBgColor, shape: BoxShape.circle),
          padding: EdgeInsets.all(12),
          child: imageAsset(
            img: iconName,
            width: 20.0,
            height: 20.0,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: TextComponent(
              title: title,
              fontWeight: FontWeight.w600,
              fontSize: 17,
            ),
          ),
        ),
      ],
    );
  }
}
