import 'package:flutter/material.dart';

enum InitialPosition { start, center, end }

class HorizantalPicker extends StatefulWidget {
  final int minValue, maxValue;
  final Function(int) onChanged;
  final InitialPosition initialPosition;
  final TextStyle activeTextStyle;
  final TextStyle deActiveTextStyle;
  final Color activeItemBgColor;
  final int currentItem;
  final double height;
  final double circleRadius;

  HorizantalPicker({
    @required this.minValue,
    @required this.maxValue,
    @required this.onChanged,
    this.initialPosition = InitialPosition.center,
    this.currentItem = 4,
    this.height = 100,
    this.circleRadius = 30,
    this.activeTextStyle = const TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.bold,
    ),
    this.deActiveTextStyle = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
    this.activeItemBgColor = Colors.white,
  })  : assert(minValue < maxValue),
        assert(onChanged != null);

  @override
  _HorizantalPickerState createState() => _HorizantalPickerState();
}

class _HorizantalPickerState extends State<HorizantalPicker> {
  List<int> valueList = [];

  FixedExtentScrollController _scrollController;
  int curItem;

  @override
  void initState() {
    super.initState();
    curItem = widget.currentItem;
    _scrollController = FixedExtentScrollController(initialItem: curItem);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3),
      margin: EdgeInsets.all(20),
      alignment: Alignment.center,
      height: widget.height,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            RotatedBox(
              quarterTurns: 3,
              child: ListWheelScrollView(
                controller: _scrollController,
                itemExtent: 70,
                onSelectedItemChanged: (item) {
                  setState(() {
                    curItem = item;
                    widget.onChanged(item + 1);
                  });
                  setState(() {});
                },
                children: List.generate(
                  widget.maxValue,
                  (index) => ItemWidget(
                    title: (index + 1).toString(),
                    activeBgColor: widget.activeItemBgColor,
                    activeTextStyle: widget.activeTextStyle,
                    deActiveTextStyle: widget.deActiveTextStyle,
                    isSelected: curItem == index,
                    radius: widget.circleRadius,
                  ),
                ).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemWidget extends StatelessWidget {
  final bool isSelected;
  final String title;
  final Color activeBgColor;
  final TextStyle activeTextStyle;
  final TextStyle deActiveTextStyle;
  final double radius;

  const ItemWidget({
    this.isSelected,
    this.title,
    this.deActiveTextStyle,
    this.activeTextStyle,
    this.activeBgColor,
    this.radius = 30,
  });

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 1,
      child: CircleAvatar(
        backgroundColor: isSelected ? activeBgColor : Colors.white,
        radius: radius,
        child: Text(
          title,
          style: isSelected ? activeTextStyle : deActiveTextStyle,
        ),
      ),
    );
  }
}
