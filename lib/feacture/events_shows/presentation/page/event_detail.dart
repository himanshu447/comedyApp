import 'package:comedy/common/general_widget.dart';
import 'package:comedy/feacture/events_shows/data/model/event_show_model.dart';
import 'package:comedy/feacture/events_shows/presentation/widget/event_detail_widget.dart';
import 'package:comedy/utils/color_util.dart';
import 'package:comedy/utils/component/text_component.dart';
import 'package:comedy/utils/icons_utils.dart';
import 'package:comedy/utils/string_util.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventDetail extends StatefulWidget {
  final EventShowModel eventShowModel;

  const EventDetail({
    Key key,
    @required this.eventShowModel,
  }) : super(key: key);

  @override
  _EventDetailState createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
  @override
  Widget build(BuildContext context) {

    var startDateFromApi = widget.eventShowModel.startTime.split(':');
    var endDateFromApi = widget.eventShowModel.endTime.split(':');

    var startDate = DateTime(
      widget.eventShowModel.startDate.year,
      widget.eventShowModel.startDate.month,
      widget.eventShowModel.startDate.weekday,
      int.parse(startDateFromApi[0]),
      int.parse(startDateFromApi[1]),
      int.parse(startDateFromApi[2]),
    );

    var endDate = DateTime(
      widget.eventShowModel.endDate.year,
      widget.eventShowModel.endDate.month,
      widget.eventShowModel.endDate.weekday,
      int.parse(endDateFromApi[0]),
      int.parse(endDateFromApi[1]),
      int.parse(endDateFromApi[2]),
    );

    String finalStartDate = DateFormat('MMM d H:mm:ss a').format(startDate);
    String finalEndDate = DateFormat('MMM d H:mm:ss a').format(endDate);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            eventTopWidget(
                context: context, imageUrl: widget.eventShowModel.image),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  eventScheduleDate('$finalStartDate - $finalEndDate'),
                  eventTitle(widget.eventShowModel.name),
                  verticalSpace(20),
                  descriptionTile(
                      title: '\$${widget.eventShowModel.cost}',
                      iconName: AppIcons.ic_ticket),
                  verticalSpace(20),
                  descriptionTile(
                      title: widget.eventShowModel.eventLink,
                      iconName: AppIcons.ic_web),
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
                    title: widget.eventShowModel.about,
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
