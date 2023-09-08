import 'package:flutter/material.dart';

import 'color_constants.dart';
import 'font_constants.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: ColorConstants.backgroundColor,
    fontFamily: FontConstants.montserrat,
    fontFamilyFallback: const [FontConstants.roboto],
    primaryColor: ColorConstants.primaryColor,
    appBarTheme: const AppBarTheme(
      color: ColorConstants.backgroundColor,
      surfaceTintColor: ColorConstants.textPinkColor,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      hintStyle: TextStyle(
        fontFamily: FontConstants.roboto,
        fontWeight: FontWeight.w300,
        fontSize: 16,
        color: ColorConstants.placeHolderColor,
      ),
      errorMaxLines: 3,
      errorStyle: TextStyle(
        fontFamily: FontConstants.roboto,
        fontWeight: FontWeight.w300,
        fontSize: 12,
        color: ColorConstants.primaryColor,
      ),
      prefixIconColor: ColorConstants.primaryColor,
      suffixIconColor: ColorConstants.primaryColor,
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        borderSide: BorderSide(
          color: ColorConstants.primaryColor,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        borderSide: BorderSide(
          color: ColorConstants.primaryColor,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        borderSide: BorderSide(
          color: ColorConstants.primaryColor,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        borderSide: BorderSide(
          color: ColorConstants.primaryColor,
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        borderSide: BorderSide(
          color: ColorConstants.secondaryColor,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size.fromHeight(50),
        foregroundColor: ColorConstants.primaryColor,
        backgroundColor: ColorConstants.buttonBGColor,
        side: const BorderSide(color: ColorConstants.buttonBGColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        textStyle: const TextStyle(
            fontFamily: FontConstants.montserrat,
            fontSize: 16,
            fontWeight: FontWeight.w900,
            color: ColorConstants.textColor),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorConstants.primaryColor,
        textStyle: const TextStyle(
            fontFamily: FontConstants.montserrat,
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.black),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
          surfaceTintColor: ColorConstants.textPinkColor,
          foregroundColor: ColorConstants.textPinkColor,
          disabledForegroundColor: ColorConstants.secondaryColor),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: ColorConstants.primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      textTheme: ButtonTextTheme.primary,
    ),
    textTheme: textThemeLight(),
  );
}

textThemeLight() {
  return const TextTheme(
    bodyLarge: TextStyle(
        fontFamily: FontConstants.montserrat,
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: ColorConstants.textWhiteColor),
    displayMedium: TextStyle(
        fontFamily: FontConstants.roboto,
        fontWeight: FontWeight.w400,
        fontSize: 14,
        color: ColorConstants.textWhiteColor),
    bodyMedium: TextStyle(
        fontFamily: FontConstants.roboto,
        fontWeight: FontWeight.w400,
        fontSize: 14,
        color: ColorConstants.textPinkColor),
    bodySmall: TextStyle(
        fontFamily: FontConstants.montserrat,
        fontWeight: FontWeight.w300,
        fontSize: 16,
        color: ColorConstants.textWhiteColor),
  );
}
