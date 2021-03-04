import 'package:comedy/common/common_appbar.dart';
import 'package:comedy/common/general_widget.dart';
import 'package:comedy/feacture/events_shows/presentation/widget/event_widget.dart';
import 'package:comedy/feacture/events_shows/presentation/widget/submit_event_widget.dart';
import 'package:comedy/utils/color_util.dart';
import 'package:comedy/utils/component/text_component.dart';
import 'package:comedy/utils/icons_utils.dart';
import 'package:comedy/utils/string_util.dart';
import 'package:comedy/utils/style_util.dart';
import 'package:flutter/material.dart';

class SubmitEvents extends StatefulWidget {
  @override
  _SubmitEventsState createState() => _SubmitEventsState();
}

class _SubmitEventsState extends State<SubmitEvents> {
  TextEditingController eventNameController = TextEditingController();
  TextEditingController aboutEventController = TextEditingController();
  TextEditingController eventLinkController = TextEditingController();
  TextEditingController eventCostController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: submitButton(
            title: AppString.Submit_event_or_show, onPress: _submitData),
      ),
      appBar: customAppbar(
        context: context,
        title: AppString.event_and_shows,
        backgroundColor: AppColor.primary_pink[500],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            topAddImageWidget(size: size),
            verticalSpace(25.0),
            customTextField(
                controller: eventNameController,
                hintText: AppString.event_name),
            verticalSpace(20.0),
            customTextField(
                controller: aboutEventController,
                hintText: AppString.about_event,
                maxLine: 4),
            verticalSpace(20.0),
            Row(
              children: [
                Expanded(
                    child: timePicker(
                  hintName: AppString.start_date,
                  controller: startTimeController,
                  onTap: () {
                    selectDate(context).then((date) {
                      print(date);
                      if (date != null)
                        setState(() {
                          startTimeController.text = date;
                        });
                    });
                  },
                )),
                horizontalSpace(10),
                Expanded(
                    child: timePicker(
                  hintName: AppString.start_time,
                  controller: startDateController,
                  onTap: () {
                    selectTime(context).then((date) {
                      print(date);
                      if (date != null)
                        setState(() {
                          startDateController.text = date;
                        });
                    });
                  },
                )),
              ],
            ),
            verticalSpace(20.0),
            Row(
              children: [
                Expanded(
                    child: timePicker(
                  hintName: AppString.end_date,
                  controller: endDateController,
                  onTap: () {
                    selectDate(context).then((date) {
                      print(date);
                      if (date != null)
                        setState(() {
                          endDateController.text = date;
                        });
                    });
                  },
                )),
                horizontalSpace(10),
                Expanded(
                    child: timePicker(
                  hintName: AppString.end_date,
                  controller: endTimeController,
                  onTap: () {
                    selectTime(context).then((date) {
                      print(date);
                      if (date != null)
                        setState(() {
                          endTimeController.text = date;
                        });
                    });
                  },
                )),
              ],
            ),
            verticalSpace(20.0),
            timezoneRow(),
            verticalSpace(20.0),
            customTextField(
              controller: eventLinkController,
              hintText: AppString.event_link,
            ),
            verticalSpace(20.0),
            customTextField(
              controller: eventCostController,
              hintText: AppString.cost,
            ),
            verticalSpace(20.0),

            /*    customTextField(
                      controller: controller, hintText: 'Event Name'),
                  verticalSpace(20.0),*/
          ],
        ),
      ),
    );
  }

  Widget timePicker(
      {Function onTap, TextEditingController controller, String hintName}) {
    return customTextField(
        controller: controller,
        hintText: hintName,
        isReadOnly: true,
        onTap: onTap);
  }

  _submitData() {
    print('Submit Event');
  }

  Widget timezoneRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: TextComponent(
              title: AppString.time_zone,
              fontWeight: FontWeight.w600,
              fontSize: 17,
            ),
          ),
          TextComponent(
            title: 'GMT +3',
            fontWeight: FontWeight.w400,
            fontSize: 17,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Icon(
              Icons.arrow_forward_ios_sharp,
              size: 16,
            ),
          )
        ],
      ),
    );
  }
}
