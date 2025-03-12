import 'package:flutter/material.dart';
import 'package:news_articles/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class Utils {
  BuildContext context;
  Utils(this.context);

  bool get getTheme => Provider.of<ThemeProvider>(context).getDarkTheme;
  Color get getColor =>getTheme ? Colors.white : Colors.black;
}
