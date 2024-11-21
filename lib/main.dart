import 'package:flutter/material.dart';
import 'package:home_manager/screens/login_screen.dart';
import 'package:home_manager/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return MaterialApp(
      theme: isDarkMode
          ? ThemeData.from(colorScheme: ColorScheme.dark(primary: Colors.blue))
          : ThemeData.from(
              colorScheme: ColorScheme.light(primary: Colors.blue)),
      home: LoginScreen(),
    );
  }
}
