// import 'package:comedy/common/common_appbar.dart';
// import 'package:comedy/utils/color_util.dart';
// import 'package:comedy/utils/string_util.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/date_symbol_data_local.dart';
// import 'package:table_calendar/table_calendar.dart';
//
// final Map<DateTime, List> _holidays = {
//   DateTime(2020, 1, 1): ['New Year\'s Day'],
//   DateTime(2020, 1, 6): ['Epiphany'],
//   DateTime(2020, 2, 14): ['Valentine\'s Day'],
//   DateTime(2020, 4, 21): ['Easter Sunday'],
//   DateTime(2020, 4, 22): ['Easter Monday'],
// };
//
// class EventsShows extends StatefulWidget {
//   @override
//   _EventsShowsState createState() => _EventsShowsState();
// }
//
// class _EventsShowsState extends State<EventsShows> {
//   Map<DateTime, List> _events;
//   List _selectedEvents;
//   AnimationController _animationController;
//
//   //CalendarController _calendarController;
//
//   @override
//   void initState() {
//     super.initState();
//     final _selectedDay = DateTime.now();
//     initializeDateFormatting();
//     _events = {
//       _selectedDay.subtract(Duration(days: 30)): [
//         'Event A0',
//         'Event B0',
//         'Event C0'
//       ],
//       _selectedDay.subtract(Duration(days: 27)): ['Event A1'],
//       _selectedDay.subtract(Duration(days: 20)): [
//         'Event A2',
//         'Event B2',
//         'Event C2',
//         'Event D2'
//       ],
//       _selectedDay.subtract(Duration(days: 16)): ['Event A3', 'Event B3'],
//       _selectedDay.subtract(Duration(days: 10)): [
//         'Event A4',
//         'Event B4',
//         'Event C4'
//       ],
//       _selectedDay.subtract(Duration(days: 4)): [
//         'Event A5',
//         'Event B5',
//         'Event C5'
//       ],
//       _selectedDay.subtract(Duration(days: 2)): ['Event A6', 'Event B6'],
//       _selectedDay: ['Event A7', 'Event B7', 'Event C7', 'Event D7'],
//       _selectedDay.add(Duration(days: 1)): [
//         'Event A8',
//         'Event B8',
//         'Event C8',
//         'Event D8'
//       ],
//       _selectedDay.add(Duration(days: 3)):
//           Set.from(['Event A9', 'Event A9', 'Event B9']).toList(),
//       _selectedDay.add(Duration(days: 7)): [
//         'Event A10',
//         'Event B10',
//         'Event C10'
//       ],
//       _selectedDay.add(Duration(days: 11)): ['Event A11', 'Event B11'],
//       _selectedDay.add(Duration(days: 17)): [
//         'Event A12',
//         'Event B12',
//         'Event C12',
//         'Event D12'
//       ],
//       _selectedDay.add(Duration(days: 22)): ['Event A13', 'Event B13'],
//       _selectedDay.add(Duration(days: 26)): [
//         'Event A14',
//         'Event B14',
//         'Event C14'
//       ],
//     };
//
//     _selectedEvents = _events[_selectedDay] ?? [];
//     _calendarController = CalendarController();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: customAppbar(
//         context: context,
//         title: AppString.event_and_shows,
//         backgroundColor: AppColor.primary_pink[500],
//       ),
//       body: Column(
//         children: [
//           _buildTableCalendarWithBuilders(),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildTableCalendarWithBuilders() {
//     return TableCalendar(
//       locale: 'in',
//       calendarController: _calendarController,
//       events: _events,
//       holidays: _holidays,
//       initialCalendarFormat: CalendarFormat.month,
//       formatAnimation: FormatAnimation.slide,
//       startingDayOfWeek: StartingDayOfWeek.sunday,
//       availableGestures: AvailableGestures.all,
//       availableCalendarFormats: {
//         CalendarFormat.month: '',
//         CalendarFormat.week: '',
//       },
//       calendarStyle: CalendarStyle(
//         outsideDaysVisible: false,
//         weekendStyle: TextStyle().copyWith(color: Colors.blue[800]),
//         holidayStyle: TextStyle().copyWith(color: Colors.blue[800]),
//       ),
//       daysOfWeekStyle: DaysOfWeekStyle(
//         weekendStyle: TextStyle().copyWith(color: Colors.blue[600]),
//       ),
//       headerStyle: HeaderStyle(
//         centerHeaderTitle: true,
//         formatButtonVisible: false,
//       ),
//       builders: CalendarBuilders(
//         selectedDayBuilder: (context, date, _) {
//           return FadeTransition(
//             opacity: Tween(begin: 0.0, end: 1.0).animate(_animationController),
//             child: Container(
//               margin: const EdgeInsets.all(4.0),
//               padding: const EdgeInsets.only(top: 5.0, left: 6.0),
//               color: Colors.deepOrange[300],
//               width: 100,
//               height: 100,
//               child: Text(
//                 '${date.day}',
//                 style: TextStyle().copyWith(fontSize: 16.0),
//               ),
//             ),
//           );
//         },
//         todayDayBuilder: (context, date, _) {
//           return Container(
//             margin: const EdgeInsets.all(4.0),
//             padding: const EdgeInsets.only(top: 5.0, left: 6.0),
//             color: Colors.amber[400],
//             width: 100,
//             height: 100,
//             child: Text(
//               '${date.day}',
//               style: TextStyle().copyWith(fontSize: 16.0),
//             ),
//           );
//         },
//         markersBuilder: (context, date, events, holidays) {
//           final children = <Widget>[];
//
//           if (events.isNotEmpty) {
//             children.add(
//               Positioned(
//                 right: 1,
//                 bottom: 1,
//                 child: _buildEventsMarker(date, events),
//               ),
//             );
//           }
//
//           if (holidays.isNotEmpty) {
//             children.add(
//               Positioned(
//                 right: -2,
//                 top: -2,
//                 child: _buildHolidaysMarker(),
//               ),
//             );
//           }
//
//           return children;
//         },
//       ),
//       onDaySelected: (date, events, holidays) {
//         _onDaySelected(date, events, holidays);
//         _animationController.forward(from: 0.0);
//       },
//       onVisibleDaysChanged: _onVisibleDaysChanged,
//       onCalendarCreated: _onCalendarCreated,
//     );
//   }
//
//   void _onDaySelected(DateTime day, List events, List holidays) {
//     print('CALLBACK: _onDaySelected');
//     setState(() {
//       _selectedEvents = events;
//     });
//   }
//
//   void _onVisibleDaysChanged(
//       DateTime first, DateTime last, CalendarFormat format) {
//     print('CALLBACK: _onVisibleDaysChanged');
//   }
//
//   void _onCalendarCreated(
//       DateTime first, DateTime last, CalendarFormat format) {
//     print('CALLBACK: _onCalendarCreated');
//   }
//
//   Widget _buildHolidaysMarker() {
//     return Icon(
//       Icons.add_box,
//       size: 20.0,
//       color: Colors.blueGrey[800],
//     );
//   }
//
//   Widget _buildEventsMarker(DateTime date, List events) {
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 300),
//       decoration: BoxDecoration(
//         shape: BoxShape.rectangle,
//         color: _calendarController.isSelected(date)
//             ? Colors.brown[500]
//             : _calendarController.isToday(date)
//                 ? Colors.brown[300]
//                 : Colors.blue[400],
//       ),
//       width: 16.0,
//       height: 16.0,
//       child: Center(
//         child: Text(
//           '${events.length}',
//           style: TextStyle().copyWith(
//             color: Colors.white,
//             fontSize: 12.0,
//           ),
//         ),
//       ),
//     );
//   }
// }
