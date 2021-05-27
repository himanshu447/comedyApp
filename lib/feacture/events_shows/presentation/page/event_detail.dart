import 'package:comedy/common/general_widget.dart';
import 'package:comedy/feacture/events_shows/data/model/event_show_model.dart';
import 'package:comedy/feacture/events_shows/presentation/widget/event_detail_widget.dart';
import 'package:comedy/utils/color_util.dart';
import 'package:comedy/utils/component/text_component.dart';
import 'package:comedy/utils/helper/timer_helper.dart';
import 'package:comedy/utils/icons_utils.dart';
import 'package:comedy/utils/route/route_name.dart';
import 'package:comedy/utils/string_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
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

  String currentTimeZone = '';

  @override
  void initState() {
    super.initState();
    _fetchLocalTimeZone();
  }

  _fetchLocalTimeZone() async {
    currentTimeZone = await FlutterNativeTimezone.getLocalTimezone();
    print(currentTimeZone);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    //2021-05-27 03:35:49.000 (9:05)

    //2021-05-27 04:35:51.000 (10)

    print(widget.eventShowModel.startDate);
    print(widget.eventShowModel.endDate);


    var dateFormat = DateFormat("MMM d AT H:mm a");
    String createdStartDate = dateFormat.format(widget.eventShowModel.startDate);
    String createdEndDate = dateFormat.format(widget.eventShowModel.endDate);


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
                  eventScheduleDate('$createdStartDate - $createdEndDate'),
                  eventTitle(widget.eventShowModel.name),
                  verticalSpace(20),
                  descriptionTile(
                      title: '${widget.eventShowModel.cost}',
                      iconName: AppIcons.ic_ticket),
                  verticalSpace(20),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, RouteName.web_view,
                          arguments: widget.eventShowModel.eventLink);
                    },
                    child: descriptionTile(
                        title: widget.eventShowModel.eventLink,
                        iconName: AppIcons.ic_web,
                        textColor: AppColor.primary_blue[500]),
                  ),
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

  Widget descriptionTile({String title, iconName, Color textColor}) {
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
              color: textColor != null ? textColor : null,
            ),
          ),
        ),
      ],
    );
  }
}
