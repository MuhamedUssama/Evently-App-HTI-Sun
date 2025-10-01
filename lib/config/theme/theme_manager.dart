import 'package:evently_hti_sun/core/resources/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeManager {
  static final ThemeData light = ThemeData(
    useMaterial3: false,

    primaryColor: ColorsManager.blue,
    iconTheme: IconThemeData(color: ColorsManager.white),
    appBarTheme: AppBarTheme(
      backgroundColor: ColorsManager.whiteBlue,
      foregroundColor: ColorsManager.blue,
      titleTextStyle: TextStyle(
        fontSize: 22,
        color: ColorsManager.blue,
        fontWeight: FontWeight.w400,
      ),
      centerTitle: true,
    ),
    scaffoldBackgroundColor: ColorsManager.whiteBlue,

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: ColorsManager.white,
      unselectedItemColor: ColorsManager.white,
    ),

    bottomAppBarTheme: BottomAppBarThemeData(
      color: ColorsManager.blue,
      shape: CircularNotchedRectangle(),
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: ColorsManager.blue,
      foregroundColor: ColorsManager.white,
      shape: StadiumBorder(
        side: BorderSide(color: ColorsManager.white, width: 4),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(width: 1.w, color: ColorsManager.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(width: 1.w, color: ColorsManager.blue),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(width: 1.w, color: ColorsManager.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(width: 1.w, color: ColorsManager.red),
      ),

      labelStyle: GoogleFonts.inter(
        fontSize: 16.sp,
        color: ColorsManager.grey,
        fontWeight: FontWeight.w500,
      ),
      hintStyle: GoogleFonts.inter(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: ColorsManager.black,
      ),

      prefixIconColor: ColorsManager.grey,
      suffixIconColor: ColorsManager.grey,
    ),
    cardTheme: CardThemeData(color: Colors.white),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: REdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: ColorsManager.blue,
        foregroundColor: ColorsManager.white,
      ),
    ),

    textTheme: TextTheme(
      headlineSmall: GoogleFonts.inter(
        fontSize: 14,
        color: ColorsManager.white,
        fontWeight: FontWeight.w400,
      ),
      headlineMedium: GoogleFonts.inter(
        fontSize: 18,
        color: ColorsManager.black,
        fontWeight: FontWeight.w500,
      ),
      headlineLarge: GoogleFonts.inter(
        fontSize: 24.sp,
        color: ColorsManager.white,
        fontWeight: FontWeight.bold,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: 14.sp,
        fontWeight: FontWeight.bold,
        color: ColorsManager.blue,
      ),
      labelMedium: GoogleFonts.inter(
        fontWeight: FontWeight.bold,
        fontSize: 20.sp,
        color: ColorsManager.black,
      ),
      titleSmall: GoogleFonts.inter(
        fontSize: 14.sp,
        color: ColorsManager.black,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: GoogleFonts.inter(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: ColorsManager.black,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: ColorsManager.black,
      ),
    ),
  );
  static final ThemeData dark = ThemeData(
    useMaterial3: false,

    primaryColor: ColorsManager.darkBlue,
    iconTheme: IconThemeData(color: ColorsManager.ofWhite),
    appBarTheme: AppBarTheme(
      backgroundColor: ColorsManager.darkBlue,
      foregroundColor: ColorsManager.blue,
      titleTextStyle: TextStyle(
        fontSize: 22,
        color: ColorsManager.blue,
        fontWeight: FontWeight.w400,
      ),
      centerTitle: true,
    ),
    scaffoldBackgroundColor: ColorsManager.darkBlue,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: ColorsManager.ofWhite,
      unselectedItemColor: ColorsManager.ofWhite,
    ),

    bottomAppBarTheme: BottomAppBarThemeData(
      color: ColorsManager.darkBlue,
      shape: CircularNotchedRectangle(),
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: ColorsManager.darkBlue,
      foregroundColor: ColorsManager.ofWhite,
      shape: StadiumBorder(
        side: BorderSide(color: ColorsManager.ofWhite, width: 4),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(width: 1.w, color: ColorsManager.blue),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(width: 1.w, color: ColorsManager.blue),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(width: 1.w, color: ColorsManager.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(width: 1.w, color: ColorsManager.red),
      ),
      hintStyle: GoogleFonts.inter(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: ColorsManager.ofWhite,
      ),
      labelStyle: GoogleFonts.inter(
        fontSize: 16.sp,
        color: ColorsManager.white,
        fontWeight: FontWeight.w500,
      ),
      prefixIconColor: ColorsManager.white,
      suffixIconColor: ColorsManager.white,
    ),
    cardTheme: CardThemeData(color: ColorsManager.darkBlue),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: REdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: ColorsManager.blue,
        foregroundColor: ColorsManager.white,
      ),
    ),

    textTheme: TextTheme(
      headlineSmall: GoogleFonts.inter(
        fontSize: 14,
        color: ColorsManager.white,
        fontWeight: FontWeight.w400,
      ),
      headlineMedium: GoogleFonts.inter(
        fontSize: 18,
        color: ColorsManager.ofWhite,
        fontWeight: FontWeight.w500,
      ),
      headlineLarge: GoogleFonts.inter(
        fontSize: 24.sp,
        color: ColorsManager.white,
        fontWeight: FontWeight.bold,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: 14.sp,
        fontWeight: FontWeight.bold,
        color: ColorsManager.blue,
      ),
      labelMedium: GoogleFonts.inter(
        fontWeight: FontWeight.bold,
        fontSize: 20.sp,
        color: ColorsManager.ofWhite,
      ),
      titleSmall: GoogleFonts.inter(
        fontSize: 14.sp,
        color: ColorsManager.ofWhite,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: GoogleFonts.inter(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: ColorsManager.ofWhite,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: ColorsManager.white,
      ),
    ),
  );
}
