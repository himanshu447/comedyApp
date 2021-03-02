import 'package:comedy/common/general_widget.dart';
import 'package:comedy/utils/color_util.dart';
import 'package:comedy/utils/component/text_component.dart';
import 'package:comedy/utils/icons_utils.dart';
import 'package:comedy/utils/string_util.dart';
import 'package:comedy/utils/style_util.dart';
import 'package:flutter/material.dart';

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
}) {
  return TextFormField(
    controller: controller,
    maxLines: maxLine ?? 1,

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
