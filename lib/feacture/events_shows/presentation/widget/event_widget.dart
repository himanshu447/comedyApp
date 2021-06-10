import 'package:comedy/utils/calender/table_calendar.dart';
import 'package:comedy/utils/color_util.dart';
import 'package:comedy/utils/component/text_component.dart';
import 'package:comedy/utils/style_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EventCalender extends StatefulWidget {
  final CalendarController calendarController;
  final Function odDaySelected;
  final ValueSetter<DateTime> onAllEventButtonTap;

  const EventCalender({Key key, this.calendarController, this.odDaySelected,this.onAllEventButtonTap})
      : super(key: key);

  @override
  _EventCalenderState createState() => _EventCalenderState();
}

class _EventCalenderState extends State<EventCalender> {
  bool isSelected;

  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.textFieldBgColor,
      child: Theme(
        data: ThemeData(
          iconTheme: IconThemeData().copyWith(color: AppColor.black),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TableCalendar(
              locale: 'en_US',
              calendarController: widget.calendarController,
              initialCalendarFormat: CalendarFormat.week,
              formatAnimation: FormatAnimation.scale,
              startingDayOfWeek: StartingDayOfWeek.sunday,
              availableGestures: AvailableGestures.all,
              availableCalendarFormats: {
                CalendarFormat.month: '',
                CalendarFormat.week: '',
              },
              calendarStyle: CalendarStyle(
                outsideDaysVisible: false,
                todayStyle: StyleUtil.calenderTextStyle,
                weekendStyle: StyleUtil.calenderTextStyle,
                holidayStyle: StyleUtil.calenderTextStyle,
              ),
              daysOfWeekStyle: DaysOfWeekStyle(
                weekendStyle: TextStyle().copyWith(color: Colors.blue[600]),
              ),
              headerStyle: HeaderStyle(
                  centerHeaderTitle: true,
                  formatButtonVisible: false,
                  titleTextStyle: StyleUtil.calenderHeaderTextStyle),
              builders: CalendarBuilders(
                dayBuilder: (context, date, _) {
                  //selectedDate = date;
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColor.gry),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: const EdgeInsets.all(6.0),
                    // padding: const EdgeInsets.only(top: 5.0, left: 6.0),
                    width: 100,
                    height: 200,
                    child: Center(
                      child: Text(
                        '${date.day}',
                        style: StyleUtil.calenderTextStyle,
                      ),
                    ),
                  );
                },
                selectedDayBuilder: (context, date, _) {
                  //selectedDate = date;
                  return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppColor.primary_pink[500]),
                    margin: const EdgeInsets.all(4.0),
                    // padding: const EdgeInsets.only(top: 5.0, left: 6.0),
                    width: 100,
                    height: 200,
                    child: Center(
                      child: Text(
                        '${date.day}',
                        style: StyleUtil.calenderBodyTextStyle,
                      ),
                    ),
                  );
                },
                todayDayBuilder: (context, date, _) {
                  //selectedDate = date;
                  return isSelected
                      ? Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: AppColor.primary_pink[500]),
                          margin: const EdgeInsets.all(4.0),
                          // padding: const EdgeInsets.only(top: 5.0, left: 6.0),
                          width: 100,
                          height: 200,
                          child: Center(
                            child: Text(
                              '${date.day}',
                              style: StyleUtil.calenderBodyTextStyle,
                            ),
                          ),
                        )
                      : Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColor.gry),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          margin: const EdgeInsets.all(6.0),
                          // padding: const EdgeInsets.only(top: 5.0, left: 6.0),
                          width: 100,
                          height: 200,
                          child: Center(
                            child: Text(
                              '${date.day}',
                              style: StyleUtil.calenderTextStyle,
                            ),
                          ),
                        );
                },
                markersBuilder: (context, date, events, holidays) {

                  final children = <Widget>[];
                  return children;
                },
              ),
              onDaySelected: (date, events, holidays) {
                _onDaySelected(date, events, holidays);
                selectedDate = date;
                widget.odDaySelected(date);
              },
              onVisibleDaysChanged: _onVisibleDaysChanged,
              onCalendarCreated: _onCalendarCreated,
            ),
            TextButton(
              onPressed:  () => widget.onAllEventButtonTap(selectedDate),
              child: TextComponent(
                  title: 'All Events',
                  margin: EdgeInsets.symmetric(horizontal: 12),
                  fontSize: 16,
                  color: AppColor.primary_blue[500],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onDaySelected(DateTime day, List events, List holidays) {
    print('CALLBACK: _onDaySelected');
    setState(() {
      isSelected = false;
    });
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  void _onCalendarCreated(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onCalendarCreated');
  }
}

Widget submitButton({Function onPress, String title}) {
  return Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: 12,
      vertical: 12,
    ),
    child: RawMaterialButton(
      onPressed: onPress,
      fillColor: AppColor.primary_pink[500],
      padding: EdgeInsets.symmetric(vertical: 16,horizontal: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: TextComponent(
        title: title,
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: AppColor.white,
      ),
    ),
  );
}
