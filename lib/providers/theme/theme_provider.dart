import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studenthub/utils/theme.dart';

final themeProvider = ChangeNotifierProvider((ref) => ThemeNotifier());

class ThemeNotifier extends ChangeNotifier {
  ThemeData _themeData = ThemeData.light();

  ThemeData get themeData => _themeData;

  var isDarkMode = false;

  void setLightTheme() {
    isDarkMode = false;
    notifyListeners();
  }

  void setDarkTheme() {
    isDarkMode = true;
    notifyListeners();
  }

  set themedata(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }
}
