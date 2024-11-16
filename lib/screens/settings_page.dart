import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:home_manager/main.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeNotifier>(context).isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SwitchListTile(
              title: const Text('Dark Mode'),
              value: isDarkMode,
              onChanged: (value) {
                Provider.of<ThemeNotifier>(context, listen: false).toggleTheme();
              },
            ),
          ],
        ),
      ),
    );
  }
}
