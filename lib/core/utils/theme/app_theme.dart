import 'package:ais_reporting/core/utils/theme/color_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData appTheme = ThemeData(
      //* Colors
      primaryColorLight: const Color(0xfff99506),
      canvasColor: const Color(0xff474649),
      primaryColorDark: const Color(0xfff97316),
      scaffoldBackgroundColor: const Color(0xff38373d),

      //! Input Form decoration ..............................................................................................

      inputDecorationTheme: InputDecorationTheme(
        filled: false,
        hintStyle: GoogleFonts.poppins(
          color: Colors.grey.withOpacity(0.5),
          fontWeight: FontWeight.normal,
          letterSpacing: 0.25,
        ),

        // isDense: true,
        contentPadding: EdgeInsets.symmetric(vertical: 18.h),
        border: InputBorder.none,

        enabledBorder: InputBorder.none,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: BorderSide(color: ColorsStyles.primaryColor),
        ),
      ),
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: const Color(0xFF000812).withOpacity(0.4),
        selectionHandleColor: const Color(0xfff99506).withOpacity(0.5),
        cursorColor: const Color(0xFF000812),
      ),

      //! buttons decoration ..............................................................................................

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              return ColorsStyles.primaryColor;
            } else {
              return ColorsStyles.primaryColor;
            }
          }),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          minimumSize: MaterialStateProperty.all(Size(double.infinity, 48.h)),
          shape:
              MaterialStateProperty.all<OutlinedBorder>(const StadiumBorder()),
        ),
      ),
      dividerColor: Colors.grey);
}
