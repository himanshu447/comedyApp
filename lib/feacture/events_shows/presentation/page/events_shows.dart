import 'package:comedy/common/common_appbar.dart';
import 'package:comedy/feacture/events_shows/presentation/widget/event_widget.dart';
import 'package:comedy/utils/calender/table_calendar.dart';
import 'package:comedy/utils/color_util.dart';
import 'package:comedy/utils/component/text_component.dart';
import 'package:comedy/utils/icons_utils.dart';
import 'package:comedy/utils/string_util.dart';
import 'package:comedy/utils/style_util.dart';
import 'package:flutter/material.dart';

class EventsShows extends StatefulWidget {
  @override
  _EventsShowsState createState() => _EventsShowsState();
}

class _EventsShowsState extends State<EventsShows> {
  CalendarController _calendarController;

  @override
  void initState() {
    super.initState();

    _calendarController = CalendarController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
        context: context,
        title: AppString.event_and_shows,
        backgroundColor: AppColor.primary_pink[500],
      ),
      body: Column(
        children: [
          EventCalender(
            calendarController: _calendarController,
            odDaySelected: (date) {
              print(date);
            },
          ),
          emptyEvent(),
        ],
      ),
    );
  }

  Widget emptyEvent() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppIcons.empty_event,
            height: 150,
            width: 200.0,
          ),
          TextComponent(
            title: AppString.no_events_or_shows,
            textStyle: StyleUtil.titleHeaderTextStyle,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: submitButton(
                title: AppString.Submit_event_or_show, onPress: _submitData),
          ),
        ],
      ),
    );
  }

  _submitData() {
    print('Submit Event');
  }
}
