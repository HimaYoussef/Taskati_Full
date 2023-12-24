import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projects/core/utils/app_colors.dart';
import 'package:projects/core/utils/styles.dart';

final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.black,
    primaryColorDark: AppColors.lightScaffoldBg,
    datePickerTheme: DatePickerThemeData(
        backgroundColor: Colors.white,
        dayForegroundColor: MaterialStatePropertyAll(Colors.black),
        headerBackgroundColor: AppColors.primaryColor,
        headerForegroundColor: AppColors.whiteColor),
    fontFamily: GoogleFonts.poppins().fontFamily,
    textTheme: TextTheme(
        displayLarge: getTitleStyle(),
        displayMedium: getBodyStyle(),
        displaySmall: getSmallStyle()),
    appBarTheme: AppBarTheme(
        backgroundColor: AppColors.darkScaffoldBg,
        elevation: 0.0,
        titleTextStyle: getTitleStyle(
            color: AppColors.primaryColor,
            fontSize: 16,
            fontWeight: FontWeight.w500)),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: getSmallStyle(),
      contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor),
          borderRadius: const BorderRadius.all(Radius.circular(15))),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor),
          borderRadius: const BorderRadius.all(Radius.circular(15))),
      focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.redColor),
          borderRadius: const BorderRadius.all(Radius.circular(15))),
      errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.redColor),
          borderRadius: const BorderRadius.all(Radius.circular(15))),
    ));

final darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.darkScaffoldBg,
    primaryColor: Colors.white,
    primaryColorDark: AppColors.darkScaffoldBg,
    datePickerTheme: DatePickerThemeData(
      backgroundColor: Colors.black,
      dayForegroundColor: MaterialStatePropertyAll(Colors.white),
      headerBackgroundColor: AppColors.primaryColor,
      headerForegroundColor: AppColors.whiteColor,
      yearForegroundColor: MaterialStatePropertyAll(AppColors.whiteColor),
    ),
    timePickerTheme: TimePickerThemeData(
      backgroundColor: Colors.black,
      dayPeriodBorderSide: BorderSide(color: AppColors.lightScaffoldBg),
      dayPeriodTextColor: AppColors.lightScaffoldBg,
    ),
    fontFamily: GoogleFonts.poppins().fontFamily,
    textTheme: TextTheme(
        displayLarge: getTitleStyle(color: Colors.white),
        displayMedium: getBodyStyle(color: Colors.white),
        displaySmall: getSmallStyle()),
    appBarTheme: AppBarTheme(
        backgroundColor: AppColors.darkScaffoldBg,
        elevation: 0.0,
        titleTextStyle: getTitleStyle(
            color: AppColors.primaryColor,
            fontSize: 16,
            fontWeight: FontWeight.w500)),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: getSmallStyle(),
      contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor),
          borderRadius: const BorderRadius.all(Radius.circular(15))),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor),
          borderRadius: const BorderRadius.all(Radius.circular(15))),
      focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.redColor),
          borderRadius: const BorderRadius.all(Radius.circular(15))),
      errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.redColor),
          borderRadius: const BorderRadius.all(Radius.circular(15))),
    ));
