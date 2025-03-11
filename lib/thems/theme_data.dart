import 'package:flutter/material.dart';
import 'package:news_articles/const/global_colors.dart';

class style {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      scaffoldBackgroundColor:
      isDarkTheme ? darkScaffoldColor : lightScaffoldColor,
      primaryColor:isDarkTheme ? darkCardColor : lightCardColor,
      dialogBackgroundColor: isDarkTheme ? darkBackgroundColor : lightBackgroundColor,
      hintColor: isDarkTheme ? Colors.grey.shade400 : Colors.grey.shade700,
      textSelectionTheme: TextSelectionThemeData(
        cursorColor:isDarkTheme ? Colors.white : Colors.black,
        selectionColor: Colors.blue,

      //
      ),
     textTheme: Theme.of(context).textTheme.apply(
      bodyColor: isDarkTheme ? Colors.white : Colors.black,
      displayColor: isDarkTheme ? Colors.white : Colors.black,
     ),
       cardColor: isDarkTheme ? darkCardColor : lightCardColor,
       brightness: isDarkTheme ? Brightness.dark : Brightness.light,
       colorScheme: ThemeData().colorScheme.copyWith(
           secondary: isDarkTheme ? darkIconsColor : lightIconsColor,
           brightness: isDarkTheme ? Brightness.dark : Brightness.light,
       ),           
    );
  }
}
