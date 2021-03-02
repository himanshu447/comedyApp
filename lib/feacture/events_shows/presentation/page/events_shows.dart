import 'package:comedy/common/common_appbar.dart';
import 'package:comedy/feacture/events_shows/presentation/widget/event_list_tile_widget.dart';
import 'package:comedy/feacture/events_shows/presentation/widget/event_widget.dart';
import 'package:comedy/utils/calender/table_calendar.dart';
import 'package:comedy/utils/color_util.dart';
import 'package:comedy/utils/component/text_component.dart';
import 'package:comedy/utils/icons_utils.dart';
import 'package:comedy/utils/route/route_name.dart';
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
      bottomSheet: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: submitButton(
            title: AppString.Submit_event_or_show, onPress: _submitData),
      ),
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
          Visibility(
            visible: true,
            child: ListView.builder(
              padding: EdgeInsets.symmetric(
                horizontal: 15,
              ).copyWith(),
              shrinkWrap: true,
              itemCount: 2,
              itemBuilder: (context, index) {
                return MyEventListTile(
                  onTap: () {
                    Navigator.pushNamed(context, RouteName.event_detail);
                  },
                  eventTitle: 'Halloween (Throughout)',
                  eventTime: 'Feb 3 8:30 PM ESt',
                  eventOPrice: '180\$',
                );
              },
            ),
          ),
          Visibility(visible: false, child: emptyEvent()),
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
    Navigator.pushNamed(context, RouteName.submit_event);

    print('Submit Event');
  }
}
