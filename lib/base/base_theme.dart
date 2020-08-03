import 'package:flutter/material.dart';

import '../const/colors.dart';

const AppThemeDark = 0;
const AppThemeLight = 1;
const AppDefaultTheme = AppThemeLight;

/// Các themes cơ bản trong app
ThemeData getThemeByAppTheme(int appTheme) => _getThemeDataByAppTheme(appTheme);

ThemeData _getThemeDataByAppTheme(int themeValue) {
  switch (themeValue) {
    case AppThemeLight:
      return _getThemeData(ThemeData.light(), isDarkMode: false);
    default:
      return _getThemeData(ThemeData.dark());
  }
}

/// [isDarkMode] hiện tại để 2 Theme dark và light
ThemeData _getThemeData(ThemeData base, {bool isDarkMode = true}) {
  return base.copyWith(
    // themes
    textTheme: _basicTextTheme(base, isDarkMode: isDarkMode),
    iconTheme: _buildIconTheme(base, isDarkMode: isDarkMode),
    appBarTheme: _buildAppBarTheme(base),
    bottomAppBarTheme: _buildBottomAppBarTheme(base),
    bottomSheetTheme: _buildBottomSheetTheme(base),
    tabBarTheme: base.tabBarTheme.copyWith(
      labelColor: darkPrimaryColor,
      unselectedLabelColor: darkPrimaryColor,
    ),
    buttonTheme: _buildButtonTheme(base),
    cardTheme: _buildCardTheme(base, isDarkMode: isDarkMode),
    dialogTheme: _buildDialogTheme(base),
    // colors
    primaryColor: darkPrimaryColor,
    indicatorColor: Colors.grey,
    scaffoldBackgroundColor: isDarkMode ? darkPrimaryColor : Colors.white,
    accentColor: darkAccentColor,
    buttonColor: buttonColor,
    backgroundColor: isDarkMode ? backgroundColor : Colors.white,
  );
}

TextTheme _basicTextTheme(ThemeData base, {bool isDarkMode = true}) {
  final TextTheme _textTheme = base.textTheme;
  Color textColor = isDarkMode ? textColorDefault : Colors.black87;
  return base.textTheme.copyWith(
    // headline
    headline1: _textTheme.headline1
        .copyWith(fontSize: 36, fontWeight: FontWeight.bold, color: textColor),
    headline2: _textTheme.headline2
        .copyWith(fontSize: 32, fontWeight: FontWeight.bold, color: textColor),
    headline3: _textTheme.headline3
        .copyWith(fontSize: 26, fontWeight: FontWeight.bold, color: textColor),
    headline4: _textTheme.headline4
        .copyWith(fontSize: 24, fontWeight: FontWeight.bold, color: textColor),
    headline5: _textTheme.headline5.copyWith(fontSize: 22, color: textColor),
    headline6: _textTheme.headline6.copyWith(fontSize: 20, color: textColor),
    // subtitle
    subtitle1: _textTheme.subtitle1.copyWith(fontSize: 20, color: textColor),
    subtitle2: _textTheme.subtitle2.copyWith(fontSize: 18, color: textColor),
    // body
    bodyText1: _textTheme.bodyText1.copyWith(fontSize: 16, color: textColor),
    bodyText2: _textTheme.bodyText2.copyWith(fontSize: 14, color: textColor),
    // caption - chú thích trong app
    caption: _textTheme.caption.copyWith(fontSize: 12, color: textColor),
  );
}

IconThemeData _buildIconTheme(ThemeData base, {bool isDarkMode = true}) {
  Color iconColor = isDarkMode ? Colors.white : Colors.grey;

  return base.iconTheme.copyWith(
    color: iconColor,
    size: 20.0,
  );
}

AppBarTheme _buildAppBarTheme(ThemeData base) {
  return base.appBarTheme
      .copyWith(color: lightPrimaryColor, iconTheme: _buildIconTheme(base));
}

ButtonThemeData _buildButtonTheme(ThemeData base) {
  return base.buttonTheme.copyWith(
      minWidth: 5,
      buttonColor: buttonColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ));
}

BottomAppBarTheme _buildBottomAppBarTheme(ThemeData base) {
  return base.bottomAppBarTheme.copyWith(color: Colors.white);
}

BottomSheetThemeData _buildBottomSheetTheme(ThemeData base) {
  return base.bottomSheetTheme.copyWith(
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
    ),
  );
}

CardTheme _buildCardTheme(ThemeData base, {bool isDarkMode = true}) {
  return base.cardTheme
      .copyWith(color: isDarkMode ? Colors.black12 : Colors.grey[50]);
}

DialogTheme _buildDialogTheme(ThemeData base) {
  return base.dialogTheme.copyWith();
}
