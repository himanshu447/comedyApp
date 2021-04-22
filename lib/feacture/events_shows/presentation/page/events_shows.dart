import 'package:admob_flutter/admob_flutter.dart';
import 'package:comedy/feacture/events_shows/data/model/event_show_model.dart';
import 'package:comedy/feacture/events_shows/presentation/bloc/event_show_bloc.dart';
import 'package:comedy/feacture/events_shows/presentation/page/submit_events.dart';
import 'package:comedy/feacture/events_shows/presentation/widget/event_list_tile_widget.dart';
import 'package:comedy/feacture/events_shows/presentation/widget/event_widget.dart';
import 'package:comedy/feacture/my_saved/presentation/widget/add_tag_bottom_sheet_widget.dart';
import 'package:comedy/share/widget/add_widget.dart';
import 'package:comedy/share/widget/sub_module_app_bar_widget.dart';
import 'package:comedy/utils/calender/table_calendar.dart';
import 'package:comedy/utils/color_util.dart';
import 'package:comedy/utils/component/text_component.dart';
import 'package:comedy/utils/constant_util.dart';
import 'package:comedy/utils/icons_utils.dart';
import 'package:comedy/utils/route/route_name.dart';
import 'package:comedy/utils/string_util.dart';
import 'package:comedy/utils/style_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injector.dart';

class EventsShows extends StatefulWidget {
  @override
  _EventsShowsState createState() => _EventsShowsState();
}

class _EventsShowsState extends State<EventsShows> {
  CalendarController _calendarController;

  EventShowBloc eventShowBloc;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    eventShowBloc = injector<EventShowBloc>();
    _calendarController = CalendarController();

    eventShowBloc.add(GetEvents());
  }

  @override
  void dispose() {
    eventShowBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventShowBloc, EventShowState>(
      cubit: eventShowBloc,
      builder: (_, state) {
        if (state is EventShowInitial) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is LoadedAllEventsState) {
          print(state.dateWiseList.length);
          print(state.allList.length);
          return loadBody(list: state.dateWiseList);
        } else {
          return loadBody(list: []);
        }
      },
    );
  }

  Widget loadBody({List<EventShowModel> list}) {
    return Scaffold(
      key: _scaffoldKey,
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: list.isNotEmpty ? 20 : 0,
          vertical: 10,
        ),
        child: list.isNotEmpty
            ? submitButton(
                title: AppString.Submit_event_or_show,
                onPress: _submitData,
              )
            : Container(
                height: 50,
                //color: AppColor.gry,
                child: AdmobBanner(
                  adUnitId: ConstantUtil.getBannerAdUnitId(),
                  adSize: AdmobBannerSize.LARGE_BANNER,
                  onBannerCreated:
                      (AdmobBannerController controller) {
                    // Dispose is called automatically for you when Flutter removes the banner from the widget tree.
                    // Normally you don't need to worry about disposing this yourself, it's handled.
                    // If you need direct access to dispose, this is your guy!
                    // controller.dispose();
                  },
                ),
              ),
      ),
      body: Column(
        children: [
          SubModuleAppBarWidget(
            color: AppColor.primary_pink[500],
            title: AppString.event_and_shows,
          ),
          EventCalender(
            calendarController: _calendarController,
            odDaySelected: (DateTime date) {
              print(date);
              eventShowBloc.add(
                ChangeDateForFilter(
                  newDate: DateTime(
                    date.year,
                    date.month,
                    date.day,
                  ),
                ),
              );
            },
          ),
          Visibility(
            visible: list.isNotEmpty,
            child: Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(
                  horizontal: 15,
                ).copyWith(),
                shrinkWrap: true,
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return MyEventListTile(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        RouteName.event_detail,
                        arguments: list[index],
                      );
                    },
                    eventShowModel: list[index],
                  );
                },
              ),
            ),
          ),
          Visibility(
            visible: list.isEmpty,
            child: emptyEvent(),
          ),
        ],
      ),
    );
  }

  Widget emptyEvent() {
    return Column(
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
    );
  }

  _submitData() async {
    var result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => SubmitEvents(),
      ),
    );
    if (result != null) {
      eventShowBloc.add(GetEvents());
    }
  }
}
