import 'package:comedy/common/common_appbar.dart';
import 'package:comedy/common/general_widget.dart';
import 'package:comedy/feacture/events_shows/presentation/widget/event_widget.dart';
import 'package:comedy/feacture/events_shows/presentation/widget/submit_event_widget.dart';
import 'package:comedy/utils/color_util.dart';
import 'package:comedy/utils/component/text_component.dart';
import 'package:comedy/utils/icons_utils.dart';
import 'package:comedy/utils/string_util.dart';
import 'package:flutter/material.dart';

class SubmitEvents extends StatefulWidget {
  @override
  _SubmitEventsState createState() => _SubmitEventsState();
}

class _SubmitEventsState extends State<SubmitEvents> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBody: false,
      bottomSheet: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: submitButton(title: AppString.submit, onPress: _submitData),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                children: [
                  customTextField(
                      controller: controller, hintText: 'Event Name'),
                  verticalSpace(20.0),
                  customTextField(
                      controller: controller,
                      hintText: 'Event Name',
                      maxLine: 4),
                  verticalSpace(20.0),
                  customTextField(
                      controller: controller, hintText: 'Event Name'),
                  verticalSpace(20.0),
                  Row(
                    children: [
                      Expanded(
                        child: customTextField(
                            controller: controller, hintText: 'Event Name'),
                      ),
                      horizontalSpace(10),
                      Expanded(
                        child: customTextField(
                            controller: controller, hintText: 'Event Name'),
                      ),
                    ],
                  ),
                  verticalSpace(20.0),
                  timezoneRow(),
                  verticalSpace(20.0),
                  customTextField(
                    controller: controller,
                    hintText: 'Event Name',
                  ),
                  verticalSpace(20.0),
                  customTextField(
                      controller: controller, hintText: 'Event Name'),
                  verticalSpace(20.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _submitData() {
    print('Submit Event');
  }

  Widget timezoneRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child : TextComponent(
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
    );
  }
}
