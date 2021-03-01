import 'package:comedy/utils/color_util.dart';
import 'package:comedy/utils/component/text_component.dart';
import 'package:flutter/material.dart';

class RadioListTitleComponent<T> extends StatelessWidget {
  final T value;
  final String label;
  final bool isChecked;
  final ValueChanged<T> itemSelected;

  RadioListTitleComponent({
    @required this.value,
    @required this.label,
    @required this.itemSelected,
    this.isChecked = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      child: InkWell(
        borderRadius: BorderRadius.circular(30.0),
        onTap: () => itemSelected(this.value),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: TextComponent(
                  title: label,
                  fontWeight: FontWeight.w400,
                  fontSize: 17,
                  margin: EdgeInsets.symmetric(vertical: 2),
                ),
              ),
              Icon(
                isChecked
                    ? Icons.radio_button_checked
                    : Icons.radio_button_unchecked,
                color: AppColor.primary_blue[500],
                size: 26,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
