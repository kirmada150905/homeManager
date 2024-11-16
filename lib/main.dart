import 'package:flutter/material.dart';
import 'package:home_manager/screens/login_screen.dart';
import 'package:provider/provider.dart';

class ThemeNotifier extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeNotifier(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeNotifier>(context).isDarkMode;

    return MaterialApp(
      theme: ThemeData(
          brightness: isDarkMode ? Brightness.dark : Brightness.light,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue)),
      home: LoginScreen(),
    );
  }
}
