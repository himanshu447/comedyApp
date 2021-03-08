import 'package:flutter/material.dart';

final Color defaultColor = Colors.grey[700];

final Color defaultOnSelectColor = Colors.blue;

class BottomNav extends StatefulWidget {
  final int index;
  final void Function(int i) onTap;
  final List<BottomNavItem> items;
  final double elevation;
  final ImageStyle imageStyle;
  final Color color;
  final LabelStyle labelStyle;

  BottomNav({
    this.index,
    this.onTap,
    this.items,
    this.elevation = 8.0,
    this.imageStyle,
    this.color = Colors.white,
    this.labelStyle,
  })  : assert(items != null),
        assert(items.length >= 2);

  @override
  BottomNavState createState() => BottomNavState();
}

class BottomNavState extends State<BottomNav> {
  int currentIndex;
  ImageStyle imageStyle;
  LabelStyle labelStyle;

  @override
  void initState() {
    currentIndex = widget.index ?? 0;
    imageStyle = widget.imageStyle ?? ImageStyle();
    labelStyle = widget.labelStyle ?? LabelStyle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: widget.elevation,
      color: widget.color,
      child: SafeArea (
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: buildRowOfNavBar,
        ),
      ),
    );
  }

  List<Widget> get buildRowOfNavBar {
    List<Widget> list = [];

    widget.items.forEach((b) {
      final int i = widget.items.indexOf(b);
      final bool selected = i == currentIndex;

      if (b != null) {
        list.add(BMNavItem(
          imageProvider: b.imageProvider,
          imageSize:
              selected ? imageStyle.getSelectedSize() : imageStyle.getSize(),
          label: parseLabel(b.label, labelStyle, selected),
          onTap: () => onItemClick(i),
          textStyle: selected
              ? labelStyle.getOnSelectTextStyle()
              : labelStyle.getTextStyle(),
          imageColor:
              selected ? imageStyle.getSelectedColor() : imageStyle.getColor(),
          boxFit: imageStyle.boxFit,
        ));
      }
    });

    return list;
  }

  onItemClick(int i) {
    setState(() {
      currentIndex = i;
    });
    if (widget.onTap != null) widget.onTap(i);
  }

  parseLabel(String label, LabelStyle style, bool selected) {
    if (!style.isVisible()) {
      return null;
    }

    if (style.isShowOnSelect()) {
      return selected ? label : null;
    }

    return label;
  }
}

class BottomNavItem {
  final ImageProvider imageProvider;
  final String label;

  BottomNavItem({
    this.imageProvider,
    this.label,
  });
}

class LabelStyle {
  final bool visible;
  final bool showOnSelect;
  final TextStyle textStyle;
  final TextStyle onSelectTextStyle;

  LabelStyle({
    this.visible,
    this.showOnSelect,
    this.textStyle,
    this.onSelectTextStyle,
  });

  isVisible() {
    return visible ?? true;
  }

  isShowOnSelect() {
    return showOnSelect ?? false;
  }

  // getTextStyle returns `textStyle` with default `fontSize` and
  // `color` values if not provided. if `textStyle` is null then
  // returns default text style
  getTextStyle() {
    if (textStyle != null) {
      return TextStyle(
        inherit: textStyle.inherit,
        color: textStyle.color ?? defaultOnSelectColor,
        fontSize: textStyle.fontSize ?? 12.0,
        fontWeight: textStyle.fontWeight,
        fontStyle: textStyle.fontStyle,
        letterSpacing: textStyle.letterSpacing,
        wordSpacing: textStyle.wordSpacing,
        textBaseline: textStyle.textBaseline,
        height: textStyle.height,
        locale: textStyle.locale,
        foreground: textStyle.foreground,
        background: textStyle.background,
        decoration: textStyle.decoration,
        decorationColor: textStyle.decorationColor,
        decorationStyle: textStyle.decorationStyle,
        debugLabel: textStyle.debugLabel,
        fontFamily: textStyle.fontFamily,
      );
    }
    return TextStyle(color: defaultColor, fontSize: 12.0);
  }

  // getOnSelectTextStyle returns `onSelectTextStyle` with
  // default `fontSize` and `color` values if not provided. if
  // `onSelectTextStyle` is null then returns default text style
  getOnSelectTextStyle() {
    if (onSelectTextStyle != null) {
      return TextStyle(
        inherit: onSelectTextStyle.inherit,
        color: onSelectTextStyle.color ?? defaultOnSelectColor,
        fontSize: onSelectTextStyle.fontSize ?? 12.0,
        fontWeight: onSelectTextStyle.fontWeight,
        fontStyle: onSelectTextStyle.fontStyle,
        letterSpacing: onSelectTextStyle.letterSpacing,
        wordSpacing: onSelectTextStyle.wordSpacing,
        textBaseline: onSelectTextStyle.textBaseline,
        height: onSelectTextStyle.height,
        locale: onSelectTextStyle.locale,
        foreground: onSelectTextStyle.foreground,
        background: onSelectTextStyle.background,
        decoration: onSelectTextStyle.decoration,
        decorationColor: onSelectTextStyle.decorationColor,
        decorationStyle: onSelectTextStyle.decorationStyle,
        debugLabel: onSelectTextStyle.debugLabel,
        fontFamily: onSelectTextStyle.fontFamily,
      );
    }
    return TextStyle(color: defaultOnSelectColor, fontSize: 12.0);
  }
}

class ImageStyle {
  final double size;
  final double onSelectSize;
  final Color color;
  final Color onSelectColor;
  final BoxFit boxFit;

  ImageStyle(
      {this.size,
      this.onSelectSize,
      this.color,
      this.onSelectColor,
      this.boxFit});

  getBoxFit() {
    return boxFit ?? BoxFit.cover;
  }

  getSize() {
    return size ?? 24.0;
  }

  getSelectedSize() {
    return onSelectSize ?? 24.0;
  }

  getColor() {
    return color ?? defaultColor;
  }

  getSelectedColor() {
    return onSelectColor ?? defaultOnSelectColor;
  }
}

class BMNavItem extends StatelessWidget {
  final ImageProvider imageProvider;
  final double imageSize;
  final String label;
  final void Function() onTap;
  final Color imageColor;
  final TextStyle textStyle;
  final BoxFit boxFit;

  BMNavItem({
    this.imageProvider,
    this.imageSize,
    this.label,
    this.onTap,
    this.imageColor,
    this.textStyle,
    this.boxFit,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: InkResponse(
      key: key,
      child: Padding(
        padding: getPadding(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image(
              image: imageProvider,
              height: imageSize,
              width: imageSize,
              fit: boxFit,
            ),
            label != null ? Text(label, style: textStyle) : Container()
          ],
        ),
      ),
      highlightColor: Theme.of(context).highlightColor,
      splashColor: Theme.of(context).splashColor,
      radius: Material.defaultSplashRadius,
      onTap: () => onTap(),
    ));
  }

  // getPadding returns the padding after adjusting the top and bottom
  // padding based on the fontsize and iconSize.
  getPadding() {
    if (label != null) {
      final double p = ((56 - textStyle.fontSize) - imageSize) / 2;
      return EdgeInsets.fromLTRB(0.0, p, 0.0, p);
    }
    return EdgeInsets.fromLTRB(
        0.0, (56 - imageSize) / 2, 0.0, (56 - imageSize) / 2);
  }
}
