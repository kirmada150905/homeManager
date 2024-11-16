import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isDarkMode = false;

  // Function to change dark mode state
  void toggleDarkMode(bool value) {
    setState(() {
      isDarkMode = value;
    });
  }

  // Function to reset settings
  void resetSettings() {
    setState(() {
      isDarkMode = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        actions: [
          IconButton(
            icon: const Icon(Icons.restore),
            onPressed: () {
              // Reset settings when the icon is pressed
              resetSettings();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Dark mode toggle
            SwitchListTile(
              title: const Text('Dark Mode'),
              value: isDarkMode,
              onChanged: toggleDarkMode,
            ),
            // Reset settings button
            ElevatedButton(
              onPressed: resetSettings,
              child: const Text('Reset Settings'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
