import 'package:comedy/common/general_widget.dart';
import 'package:comedy/utils/color_util.dart';
import 'package:comedy/utils/component/text_component.dart';
import 'package:comedy/utils/icons_utils.dart';
import 'package:comedy/utils/string_util.dart';
import 'package:comedy/utils/style_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget topAddImageWidget({Size size}) {
  return Container(
    height: size.height / 4,
    width: size.width,
    color: AppColor.primary_pink[50],
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        imageAsset(
            img: AppIcons.ic_add_image_place_holder,
            width: 100.0,
            height: 100.0),
        verticalSpace(10),
        TextComponent(
          title: AppString.add_Photo,
          color: AppColor.primary_pink[500],
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
      ],
    ),
  );
}

Widget customTextField({
  TextEditingController controller,
  String hintText,
  var maxLine,
  Function onTap,
  Function validator,
  bool isReadOnly = false,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    child: TextFormField(
      onTap: onTap,
      controller: controller,
      maxLines: maxLine ?? 1,
      readOnly: isReadOnly,
      decoration: InputDecoration(
        hintText: hintText,
      ).copyWith(
          focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          color: AppColor.textFieldBgColor,
          width: 0,
        ),
      )),
      validator: validator,
      // validator: (value) {
      //   if (value.isEmpty) {
      //     return AppString.error_required_email;
      //   }
      //   return null;
      // },
      style: StyleUtil.formFieldTextStyle,
      textInputAction: TextInputAction.next,
    ),
  );
}

Widget customHeightTextField({
  TextEditingController controller,
  String hintText,
}) {
  return TextFormField(
    controller: controller,
    maxLines: 4,
    decoration: InputDecoration(
      hintText: hintText,
    ),
    validator: (value) {
      if (value.isEmpty) {
        return AppString.error_required_email;
      }
      return null;
    },
    style: StyleUtil.formFieldTextStyle,
    textInputAction: TextInputAction.next,
  );
}

Future<String> selectDate(BuildContext context) async {
  DateTime _selectedDate;
  DateTime selectedDate = DateTime.now();

  DateTime pickedDate = await showModalBottomSheet<DateTime>(
      context: context,
      builder: (context) {
        DateTime tempPickedDate;
        return Container(
          height: MediaQuery.of(context).size.height * 0.3,
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CupertinoButton(
                      child: Text('Cancel'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    CupertinoButton(
                      child: Text('Done'),
                      onPressed: () {
                        Navigator.of(context)
                            .pop(tempPickedDate ?? selectedDate);
                      },
                    ),
                  ],
                ),
              ),
              Divider(
                height: 0,
                thickness: 1,
              ),
              Expanded(
                child: Container(
                  color: AppColor.datePickerBackColor,
                  child: CupertinoDatePicker(
                    maximumDate: DateTime.now(),
                    use24hFormat: false,
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: selectedDate,
                    onDateTimeChanged: (datetime) {
                      if (datetime != null) {
                        tempPickedDate = datetime;
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      });

  if (pickedDate != null) {
    _selectedDate = pickedDate;
    print(_selectedDate.toString() + ' selected date');
    String selected =
        dateFormat(dateTime: _selectedDate, format: 'dd MMMM, yyyy');
    print(selected);
    return selected;
  }
/*  CupertinoDatePicker(
    maximumYear: 2022,
    use24hFormat: false,
    minimumYear: DateTime.now().year,
    mode: CupertinoDatePickerMode.date,
    initialDateTime: selectedDate,
    onDateTimeChanged: (datetime) {
      if (datetime != null) {
        return datetime;
      }
    },
  );*/
/*      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015),
      lastDate: DateTime(2101));
  if (picked != null && picked != selectedDate) return selectedDate;*/
}

Future selectTime(BuildContext context) async {
  DateTime _selectedDate;
  DateTime selectedDate = DateTime.now();

  var now = DateTime.now();

  var today = new DateTime(now.year, now.month, now.day);

  DateTime pickedDate = await showModalBottomSheet<DateTime>(
      context: context,
      builder: (context) {
        DateTime tempPickedDate;
        return Container(
          height: MediaQuery.of(context).size.height * 0.3,
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    CupertinoButton(
                      child: Text('Done'),
                      onPressed: () {
                        Navigator.of(context)
                            .pop(tempPickedDate ?? selectedDate);
                      },
                    ),
                  ],
                ),
              ),
              Divider(
                height: 0,
                thickness: 1,
              ),
              Expanded(
                child: Container(
                  color: AppColor.datePickerBackColor,
                  child: CupertinoDatePicker(
                    onDateTimeChanged: (duration) {
                      tempPickedDate = duration;
                    },
                    mode: CupertinoDatePickerMode.time,
                    minimumDate: today,
                    minuteInterval: 1,
                  ),
                ),
              ),
            ],
          ),
        );
      });

  if (pickedDate != null) {
    _selectedDate = pickedDate;
    print(_selectedDate.toString() + ' selected date');
    String selected = DateFormat.jm().format(_selectedDate);
    print(selected);
    return selected;
  }
/*  CupertinoDatePicker(
    maximumYear: 2022,
    use24hFormat: false,
    minimumYear: DateTime.now().year,
    mode: CupertinoDatePickerMode.date,
    initialDateTime: selectedDate,
    onDateTimeChanged: (datetime) {
      if (datetime != null) {
        return datetime;
      }
    },
  );*/
/*      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015),
      lastDate: DateTime(2101));
  if (picked != null && picked != selectedDate) return selectedDate;*/
}
