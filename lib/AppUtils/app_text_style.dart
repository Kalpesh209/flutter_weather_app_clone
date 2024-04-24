import 'package:flutter/material.dart';
import 'package:flutter_weather_app_clone/AppUtils/app_font_size.dart';
import 'package:flutter_weather_app_clone/AppUtils/app_font_weight.dart';

/*
Title: AppTextStyle Used through App
Purpose:AppTextStyle Used through App
Created On:24/04/2024
Edited On:24/04/2024
Author: Kalpesh Khandla
*/

class AppTextStyle {
  // 24 Font Size

  static TextStyle gilroy24Regular({Color? color}) => TextStyle(
        fontFamily: 'Gilroy',
        fontSize: AppFontSize.fontSize24,
        fontWeight: AppFontWeight.fontWeight400,
        color: color,
      );

  static TextStyle gilroy24SemiBold({Color? color}) => TextStyle(
        fontFamily: 'Gilroy',
        fontSize: AppFontSize.fontSize24,
        fontWeight: AppFontWeight.fontWeight600,
        color: color,
      );

  // 12 Font Size
  static TextStyle gilroy12Regular({Color? color}) => TextStyle(
        fontFamily: 'Gilroy',
        fontSize: AppFontSize.fontSize12,
        fontWeight: FontWeight.w400,
        color: color,
      );

  static TextStyle gilroy12SemiBold({Color? color}) => TextStyle(
        fontFamily: 'Gilroy',
        fontSize: AppFontSize.fontSize12,
        fontWeight: AppFontWeight.fontWeight600,
        color: color,
      );

  static TextStyle gilroy12Bold({Color? color}) => TextStyle(
        fontFamily: 'Gilroy',
        fontSize: 12,
        fontWeight: AppFontWeight.fontWeightBold,
        color: color,
      );

  static TextStyle gilroy12ExtraBold({Color? color}) => TextStyle(
        fontFamily: 'Gilroy',
        fontSize: 12,
        fontWeight: AppFontWeight.fontWeight800,
        color: color,
      );

  // 18 Family

  static TextStyle gilroys18Regular({Color? color}) => TextStyle(
        fontFamily: 'Gilroy',
        fontSize: AppFontSize.fontSize18,
        fontWeight: AppFontWeight.fontWeight400,
        color: color,
      );

  static TextStyle gilroy18Light({Color? color}) => TextStyle(
        fontFamily: 'Gilroy',
        fontSize: AppFontSize.fontSize18,
        color: color,
        fontWeight: AppFontWeight.fontWeight400,
      );

  static TextStyle gilroy18Medium({Color? color}) => TextStyle(
        fontFamily: 'Gilroy',
        fontSize: AppFontSize.fontSize18,
        color: color,
        fontWeight: AppFontWeight.fontWeight500,
      );

  static TextStyle gilroySemiBold({Color? color}) => TextStyle(
        fontFamily: 'Gilroy',
        fontSize: AppFontSize.fontSize18,
        fontWeight: AppFontWeight.fontWeight600,
        color: color,
      );
}
