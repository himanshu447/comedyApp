import 'package:comedy/utils/component/text_component.dart';
import 'package:flutter/material.dart';

import '../color_util.dart';

class InputChipComponent extends StatefulWidget {
  final Color iconColor;
  final Color chipColor;
  final InputDecoration decoration;
  final TextInputType keyboardType;
  final List<String> list;
  final EdgeInsets padding;
  final ValueSetter<String> onRemoveCallBack;
  final ValueSetter<String> onAddCallBack;
  final String hintText;
  final Color chipTextColor;

  const InputChipComponent({
    Key key,
    this.iconColor,
    this.chipColor,
    this.decoration,
    this.keyboardType,
    @required this.list,
    this.padding = const EdgeInsets.all(8),
    @required this.onAddCallBack,
    this.onRemoveCallBack,
    this.hintText,
    this.chipTextColor,
  }) : super(key: key);

  @override
  _InputChipComponentState createState() => _InputChipComponentState();
}

class _InputChipComponentState extends State<InputChipComponent>
    with SingleTickerProviderStateMixin {
  var _controller = TextEditingController();
  final FocusNode _hasTagFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: widget.padding,
          child: TextFormField(
            controller: _controller,
            focusNode: _hasTagFocusNode,
            onTap: () {
              setState(() {
                FocusScope.of(context).requestFocus(_hasTagFocusNode);
              });
            },
            decoration: InputDecoration(
              hintText: widget.hintText,
              fillColor: _hasTagFocusNode.hasFocus
                  ? AppColor.white
                  : AppColor.textFieldBgColor,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  color: Colors.black,
                  width: 0,
                ),
              ),
            ),
            keyboardType: widget.keyboardType ?? TextInputType.text,
            onChanged: (value) {
              if (value.endsWith(",")) {
                widget.onAddCallBack(value.substring(0, value.length - 1));
                _controller.clear();
              }
            },
          ),
        ),
        Visibility(
          visible: widget.list.length > 0,
          child: Wrap(
						crossAxisAlignment: WrapCrossAlignment.start,
            children: widget.list
                .map((e) => FilterChip(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      backgroundColor: widget.chipColor ?? Colors.blue,
                      label: TextComponent(
                        title: e,
                        color: widget.chipTextColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      //avatar: Icon(Icons.remove_circle_outline, color: widget.iconColor ?? Colors.white),
                      onSelected: (value) {
                        //widget.onRemoveCallBack(e);
                      },
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}
