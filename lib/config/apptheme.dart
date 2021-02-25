import 'dart:ui';

import 'package:comedy/utils/color_util.dart';
import 'package:flutter/material.dart';

class AppTheme extends StatelessWidget {
  const AppTheme({this.child});

  final Widget child;


  static ThemeData themeColors(BuildContext context) => ThemeData(
    platform: Theme.of(context).platform,
    fontFamily: 'Poppins',
    /*  primarySwatch: AppColor.primary_blue[500],
    accentIconTheme: Theme.of(context).accentIconTheme.copyWith(color: accentColor),
    accentColor: accentColor,*/
    canvasColor: Colors.transparent,
    backgroundColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: Theme.of(context).appBarTheme.copyWith(
      elevation: 0,
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: AppColor.gry,
      labelStyle: const TextStyle(color: Colors.black),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          color: Colors.transparent,
          width: 0,
        ),
      ),
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      errorStyle: const TextStyle(color: Colors.red),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: const BorderSide(
          color: Colors.red,
        ),
      ),
      /* focusColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: const BorderSide(
              color: const Color(_primaryValue),
            ),
          ),*/
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: BorderSide(
          color: Colors.grey.shade400,
        ),
      ),
    ),
    textTheme: Theme.of(context).textTheme.copyWith(
      caption: const TextStyle(
        color: Colors.black,
      ),
    ),
    /*floatingActionButtonTheme:
    Theme.of(context).floatingActionButtonTheme.copyWith(
      backgroundColor: accent,
    ),*/
    /*buttonTheme: Theme.of(context).buttonTheme.copyWith(
      textTheme: ButtonTextTheme.normal,
      colorScheme: ColorScheme.fromSwatch(
        accentColor: accentColor,
        primarySwatch: primary,
        brightness: Brightness.light,
        errorColor: Colors.red,
        backgroundColor: accentColor,
      ),
      buttonColor: const Color(_accentValue),
      shape: const StadiumBorder(),
    ),*/
  );

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppTheme.themeColors(context),
      child: this.child,
    );
  }
}
