import 'package:flutter/material.dart';

enum InitialPosition { start, center, end }

class HorizantalPicker extends StatefulWidget {
  final int minValue, maxValue;
  final Function(int) onChanged;
  final InitialPosition initialPosition;
  final TextStyle activeTextStyle;
  final TextStyle deActiveTextStyle;
  final Color activeItemBgColor;

  HorizantalPicker({
    @required this.minValue,
    @required this.maxValue,
    @required this.onChanged,
    this.initialPosition = InitialPosition.center,
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
  int curItem = 4;

  @override
  void initState() {
    super.initState();
    //setScrollController();
    _scrollController = FixedExtentScrollController(initialItem: curItem);
  }

  /*setScrollController() {
    int initialItem;
    switch (widget.initialPosition) {
      case InitialPosition.start:
        initialItem = 0;
        break;
      case InitialPosition.center:
        initialItem = (valueMap.length ~/ 2);
        break;
      case InitialPosition.end:
        initialItem = valueMap.length - 1;
        break;
    }

  }*/

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3),
      margin: EdgeInsets.all(20),
      height: 100,
      alignment: Alignment.center,
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

  const ItemWidget({
    this.isSelected,
    this.title,
    this.deActiveTextStyle,
    this.activeTextStyle,
    this.activeBgColor,
  });

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 1,
      child: CircleAvatar(
        backgroundColor: isSelected ? activeBgColor : Colors.white,
        radius: 30,
        child: Text(
          title,
          style: isSelected ? activeTextStyle : deActiveTextStyle,
        ),
      ),
    );
  }
}
