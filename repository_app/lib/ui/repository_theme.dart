import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class RepositoryTheme {
  static final appBarElevation = 0.0;
  static final appBarRaisedElevation = 12.0;
  static const colorAccent = Color(0xffd23f3f);
  static final colorGrey = Color(0xFF999999);
  static final backgroundGrey = Color(0xFEECF0F1);
  static final colorGrey900 = Color(0xFFCCCCCC);
  static final colorGrey2 = Color(0xFFFAFAFA);
  static final colorBlack = Color(0xE6404259);

  static MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map swatch = {};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    strengths.forEach((strength) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    });
    return MaterialColor(color.value, swatch.cast());
  }

  ThemeData build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.copyWith(
          button: TextStyle(
              fontSize: 14, color: colorGrey2, fontWeight: FontWeight.w500),
          caption: TextStyle(fontSize: 14, color: colorGrey2, height: 1.57),
          headline1: TextStyle(
              fontSize: 24, color: colorGrey2, fontWeight: FontWeight.w500),
          headline2: TextStyle(
              fontSize: 20, color: colorBlack, fontWeight: FontWeight.w500),
          headline3: TextStyle(fontSize: 16, color: colorBlack),
          bodyText1: TextStyle(fontSize: 14, color: colorGrey2, height: 1.27),
          bodyText2:
              TextStyle(fontSize: 16, color: colorGrey2, height: 22 / 16),
        );
    return ThemeData(
      appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        elevation: 0,
        color: Color.fromRGBO(210, 63, 63, 1),
        iconTheme: IconThemeData(
          color: colorGrey2,
        ),
      ),
      primaryColor: colorAccent,
      cupertinoOverrideTheme: CupertinoThemeData(
        primaryColor: Colors.black,
        textTheme: CupertinoTextThemeData(
          actionTextStyle: TextStyle(color: Colors.black),
        ),
      ),
      backgroundColor: backgroundGrey,
      scaffoldBackgroundColor: Colors.white,
      inputDecorationTheme: Theme.of(context).inputDecorationTheme.copyWith(
            enabledBorder:
                UnderlineInputBorder(borderSide: BorderSide(color: colorGrey)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: colorAccent, width: 2)),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          ),
      textTheme: GoogleFonts.rubikTextTheme(textTheme),
      buttonTheme: ButtonThemeData(
        buttonColor: colorAccent,
        height: 38,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary: colorAccent,
          textStyle: TextStyle(
            color: colorGrey2,
            fontSize: 14,
          ),
          minimumSize: Size.fromHeight(40),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          primary: colorGrey2,
          textStyle:
              Theme.of(context).textTheme.button?.apply(color: colorGrey2),
        ),
      ),
      splashColor: colorAccent,
      primaryColorLight: colorAccent,
      secondaryHeaderColor: colorAccent,
      primarySwatch: createMaterialColor(colorGrey),
    );
  }
}
