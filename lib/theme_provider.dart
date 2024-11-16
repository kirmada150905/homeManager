import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// The ThemeProvider class holds the theme mode (dark/light).
class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}
