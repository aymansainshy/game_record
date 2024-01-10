import 'package:flutter/material.dart';

class AppColors {
  // Shared Colors
  static const Color _kSharedColorWhite = Color(0xFFFFFFFF);
  static const Color _kSharedColorGrey = Colors.grey;

  // Theme Colors
  static const MaterialColor primarySwatch = Colors.deepPurple;
  static const Color primaryColorHex = Color(0xFF032A75);
  static const Color secondaryColor = Color(0xFF85C5ED);
  static const Color brawnColor = Color(0xFF383435);

  static const Color cardColor = _kSharedColorWhite;
  static const Color backgroundColor = Color(0xFFF3F3F1);

  static const Color hintColor = _kSharedColorGrey;
  static const Color indicatorColor = _kSharedColorGrey;

  static const Color dividerColor = _kSharedColorGrey;
}

final colorScheme = ColorScheme.fromSwatch(
  primarySwatch: AppColors.primarySwatch,
  backgroundColor: AppColors.backgroundColor,
  accentColor: AppColors.secondaryColor,
  cardColor: AppColors.cardColor,
);

class AppTheme {
  static final lightTheme = ThemeData(
    colorScheme: colorScheme,
    brightness: Brightness.light,
    fontFamily: "Poppins",
    indicatorColor: AppColors.indicatorColor,
    dividerColor: AppColors.dividerColor,
    hintColor: AppColors.hintColor,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(
          EdgeInsets.zero,
        ),
        backgroundColor: MaterialStateProperty.all<Color>(AppColors.primaryColorHex),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
            // side: BorderSide(color: Colors.red)
          ),
        ),
      ),
    ),
    scaffoldBackgroundColor: AppColors.backgroundColor,
    // pageTransitionsTheme: PageTransitionsTheme(
    //   builders: {
    //     TargetPlatform.android: CustomPageTransitionBuilder(),
    //     TargetPlatform.iOS: CustomPageTransitionBuilder(),
    //   },
    // ),
  );

// static final darkTheme = ThemeData(
//   brightness: Brightness.light,
//   primarySwatch: Colors.blue,
// fontFamily: "Roboto",
// colorScheme: colorScheme,
// pageTransitionsTheme: PageTransitionsTheme(
//   builders: {
//     TargetPlatform.android: CustomPageTransitionBuilder(),
//     TargetPlatform.iOS: CustomPageTransitionBuilder(),
//   },
// ),
// );
}
