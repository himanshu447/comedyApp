import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:comedy/common/general_widget.dart';
import 'package:comedy/feacture/events_shows/data/model/event_show_model.dart';
import 'package:comedy/feacture/events_shows/presentation/bloc/event_show_bloc.dart';
import 'package:comedy/feacture/events_shows/presentation/widget/event_widget.dart';
import 'package:comedy/feacture/events_shows/presentation/widget/submit_event_widget.dart';
import 'package:comedy/share/widget/custom_dialog_widget.dart';
import 'package:comedy/share/widget/sub_module_app_bar_widget.dart';
import 'package:comedy/utils/color_util.dart';
import 'package:comedy/utils/component/text_component.dart';
import 'package:comedy/utils/string_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

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

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  final _eventkey = GlobalKey<FormState>();

  EventShowBloc eventShowBloc;

  DateTime startDate;
  DateTime endDate;
  DateTime startTime;
  DateTime endTime;

  final picker = ImagePicker();
  String image;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    eventShowBloc = BlocProvider.of<EventShowBloc>(context, listen: true);

    print('length is ---->${eventShowBloc.state.eventList.length}');

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    eventShowBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      listener: (_, state) {
        if (state is SubmittingEventShowState) {
          CustomDialogs.showSavingDataDialog(
            context: context,
            title: AppString.event_submitting,
          );
        } else if (state is SubmittedEventShowState) {
          Navigator.pop(context);
          Navigator.pop(context, state.eventShowModel);
          eventShowBloc.add(
            AddSubmittedEventInToListEvent(
              eventShowModel: state.eventShowModel,
            ),
          );
        } else if (state is ErrorState) {
          showSnackBar(msg: state.message);
        }
      },
      cubit: eventShowBloc,
      child: BlocBuilder<EventShowBloc, EventShowState>(
        cubit: eventShowBloc,
        builder: (_, state) {
          return loadBody();
        },
      ),
    );
  }

  Widget loadBody() {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: submitButton(
            title: AppString.Submit_event_or_show, onPress: _submitData),
      ),
      body: Column(
        children: [
          SubModuleAppBarWidget(
            color: AppColor.primary_pink[500],
            title: AppString.event_and_shows,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: _eventkey,
                child: Column(
                  children: [
                    InkWell(
                      onTap: () async {
                        final pickedFile =
                            await picker.getImage(source: ImageSource.gallery);
                        setState(() {
                          image = pickedFile.path;
                        });
                      },
                      child: Container(
                        height: size.height / 4,
                        width: size.width,
                        color: AppColor.primary_pink[50],
                        child: CachedNetworkImage(
                          imageUrl: '',
                          fit: BoxFit.fill,
                          errorWidget: (ctx, url, _) {
                            return image != null
                                ? Image.file(
                                    File(image),
                                    fit: BoxFit.fill,
                                  )
                                : topAddImageWidget(size: size);
                          },
                        ),
                      ),
                    ),
                    verticalSpace(25.0),
                    customTextField(
                        controller: eventNameController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please Enter a Eventname";
                          }
                          return null;
                        },
                        hintText: AppString.event_name),
                    verticalSpace(20.0),
                    customTextField(
                        controller: aboutEventController,
                        hintText: AppString.about_event,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please Enter a AboutEvent";
                          }
                          return null;
                        },
                        maxLine: 4),
                    verticalSpace(20.0),
                    Row(
                      children: [
                        Expanded(
                            child: timePicker(
                          hintName: AppString.start_date,
                          controller: startDateController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please Enter a Start Date";
                            }
                            return null;
                          },
                          onTap: () {
                            selectDate(context).then((date) {
                              print(date);
                              if (date != null)
                                setState(() {
                                  startDateController.text = date[0];
                                  startDate = date[1];
                                });
                            });
                          },
                        )),
                        horizontalSpace(10),
                        Expanded(
                            child: timePicker(
                          hintName: AppString.start_time,
                          controller: startTimeController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please Enter a Start Time";
                            }
                            return null;
                          },
                          onTap: () {
                            selectTime(context).then((date) {
                              print(date);
                              if (date != null)
                                setState(() {
                                  startTimeController.text = date[0];
                                  startTime = date[1];
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
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please Enter a EndDate";
                            }
                            return null;
                          },
                          onTap: () {
                            selectDate(context).then((date) {
                              print(date);
                              if (date != null)
                                setState(() {
                                  endDateController.text = date[0];
                                  endDate = date[1];
                                });
                            });
                          },
                        )),
                        horizontalSpace(10),
                        Expanded(
                            child: timePicker(
                          hintName: AppString.end_date,
                          controller: endTimeController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please Enter a EndTime";
                            }
                            return null;
                          },
                          onTap: () {
                            selectTime(context).then((date) {
                              print(date);
                              if (date != null)
                                setState(() {
                                  endTimeController.text = date[0];
                                  endTime = date[1];
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
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please Enter a Event Link";
                        }
                        return null;
                      },
                      hintText: AppString.event_link,
                    ),
                    verticalSpace(20.0),
                    customTextField(
                      controller: eventCostController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please Enter a Event Cost";
                        }
                        return null;
                      },
                      hintText: AppString.cost,
                    ),
                    verticalSpace(20.0),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget timePicker(
      {Function onTap,
      TextEditingController controller,
      String hintName,
      Function validator}) {
    return customTextField(
        controller: controller,
        hintText: hintName,
        isReadOnly: true,
        onTap: onTap);
  }

  _submitData() {
    if (_eventkey.currentState.validate()) {
      eventShowBloc.add(
        SubmitEventAndShowsEvent(
          eventShowModel: EventShowModel(
            name: eventNameController.text.trim(),
            about: aboutEventController.text.trim(),
            startDate: startDate,
            endDate: endDate,
            updatedAt: DateTime.now(),
            cost: int.parse(eventCostController.text.trim()),
            endTime: endTimeController.text.trim(),
            startTime: DateFormat.Hms().format(startTime),
            eventLink: DateFormat.Hms().format(endTime),
            image: image,
          ),
        ),
      );
    } else {
      print('Not success');
    }
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

  showSnackBar({String msg}) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: TextComponent(
          title: msg,
          color: AppColor.white,
          fontSize: 16,
        ),
      ),
    );
  }
}
