import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neighborgood/presentation/_core/widgets/buttons.dart';

class AppTheme {
  AppTheme._();

  static const backgroundColor = Colors.white;
  static const Color buttonColor = Color(0xFFFF6D00);
  static const borderColor = Color(0xFFDDDDDD);
  static const redColor = Color(0xFFFF2626);
  static const feedBgColor = Color(0xFFFAFAFA);
  static const hashTextColor = Color(0xFF2D68FE);
  static const seeMoreTextColor = Color(0xFF8A8A8A);
  static const secondaryButtonColor = Color(0xFFF0F0F0);



  static final ThemeData lightTheme = ThemeData(
    splashFactory: NoSplash.splashFactory,
    brightness: Brightness.light,
    scaffoldBackgroundColor: backgroundColor,
    primaryColor: buttonColor,
    textTheme: darkTextTheme,
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      backgroundColor: backgroundColor,
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        minimumSize: const Size(250.0, 50.0).wrapMatProp(),
        padding: const EdgeInsets.only(
          top: 6.0,
          bottom: 9.0,
          left: 20.0,
          right: 20.0,
        ).wrapMatProp(),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)).wrapMatProp(),
        overlayColor: Colors.black12.wrapMatProp(),
      ),
    ),
  );

  static TextTheme darkTextTheme = const TextTheme(
    displayLarge: _headline1,
    displayMedium: _headline2,
    displaySmall: _headline3,
    titleMedium: _subtitle1,
    titleSmall: _subtitle2,
  ).apply(bodyColor: Colors.black, displayColor: Colors.black);

  static const TextStyle _headline1 = TextStyle(
    fontSize: 36.0,
    letterSpacing: 0,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle _headline2 = TextStyle(
    fontSize: 30.0,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle _headline3 = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle _subtitle1 = TextStyle(
    fontSize: 21.0,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle _subtitle2 = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
  );
}
