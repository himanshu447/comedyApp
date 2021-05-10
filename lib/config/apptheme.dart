import 'dart:ui';

import 'package:comedy/utils/color_util.dart';
import 'package:flutter/cupertino.dart';
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
          fillColor: AppColor.textFieldBgColor,
          filled: true,
          labelStyle: const TextStyle(color: Colors.black),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: AppColor.textFieldBgColor,
              width: 0,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: Colors.transparent,
              width: 0,
            ),
          ),
          hintStyle: TextStyle(
            fontSize: 17,
            fontFamily: 'SF Pro Display',
            fontWeight: FontWeight.w400,
            color: AppColor.gry,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          errorStyle: const TextStyle(
            fontSize: 16,
            fontFamily: 'SF Pro Display',
            fontWeight: FontWeight.w400,
            color: AppColor.error,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: AppColor.error,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
            borderSide: BorderSide(
              color: Colors.transparent,
              width: 0
            ),
          ),
        ),

        textTheme: Theme.of(context).textTheme.copyWith(
              caption: const TextStyle(
                color: Colors.black,
                fontSize: 20
              ),
            ),
        /*floatingActionButtonTheme:
    Theme.of(context).floatingActionButtonTheme.copyWith(
      backgroundColor: accent,
    ),*/
        buttonTheme: Theme.of(context).buttonTheme.copyWith(
              textTheme: ButtonTextTheme.normal,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
            ),
      );

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppTheme.themeColors(context),
      child: this.child,
    );
  }
}
