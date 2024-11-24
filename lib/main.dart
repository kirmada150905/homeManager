import 'package:flutter/material.dart';
import 'package:home_manager/go_router.dart';
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
    return MaterialApp.router(
        routerConfig: go_router,
        theme: isDarkMode
            ? ThemeData.from(
                colorScheme: ColorScheme.dark(primary: Colors.blue),
              ).copyWith(
                cardTheme: CardTheme(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: Colors.white, width: 0.5),
                  ),
                  elevation: 5,
                ),
              )
            : ThemeData.from(
                colorScheme: ColorScheme.light(primary: Colors.blueAccent),
              ).copyWith(
                cardTheme: CardTheme(
                  color: const Color.fromARGB(250, 255, 254, 254),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: Colors.blueAccent, width: 0.5),
                  ),
                  elevation: 5,
                ),
              ));
  }
}
