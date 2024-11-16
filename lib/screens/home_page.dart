import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home_manager/screens/detailed_room_view.dart';
import 'package:home_manager/screens/settings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, dynamic> jsonData = {"items": {}};

  @override
  void initState() {
    super.initState();
    // Load JSON data as soon as the page is created
    readJsonFile();
  }

  Future<void> readJsonFile() async {
    try {
      // Load the JSON file as a string
      String jsonString = await rootBundle.loadString('assets/room_data.json');

      // Parse the JSON string into a Dart object
      jsonData = jsonDecode(jsonString);
      // Access data from the JSON
      print('Items: ${jsonData['items']}');
      setState(() {}); // Update the UI after loading the data
    } catch (e) {
      print('Error reading JSON file: $e');
    }
  }

  bool isDarkMode = false;

  // Toggle dark mode and update state
  void toggleDarkMode(bool value) {
    setState(() {
      isDarkMode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              const PopupMenuItem(value: 1, child: Text("Settings")),
              const PopupMenuItem(value: 2, child: Text("Info")),
              const PopupMenuItem(value: 3, child: Text("Sign Out")),
            ],
            onSelected: (value) {
              if (value == 1) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return SettingsPage();
                    },
                  ),
                );
              }
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [
            jsonData.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      itemCount: jsonData["items"].length,
                      itemBuilder: (context, index) {
                        return RoomTile(room: jsonData["items"][index]);
                      },
                    ),
                  )
                : const Text("click button to load"),
            Container(
              height: 250,
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        readJsonFile().then((_) {
                          setState(() {});
                        });
                      },
                      child: const Text("reset"),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        _showMyDialog(context).then((newRoomName) {
                          if (newRoomName != null && newRoomName.isNotEmpty) {
                            setState(() {
                              jsonData["items"].add({"name": newRoomName});
                            });
                          }
                        });
                      },
                      child: const Text("New Room"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RoomTile extends StatefulWidget {
  final Map<String, dynamic> room;
  const RoomTile({super.key, required this.room});

  @override
  State<RoomTile> createState() => _RoomTileState();
}

class _RoomTileState extends State<RoomTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailedRoomView(room: widget.room)),
        );
      },
      child: Card(
        child: ListTile(
          title: Text(widget.room["name"]),
          trailing: IconButton(
            onPressed: () {},
            icon: Icon(Icons.arrow_forward_ios),
          ),
        ),
      ),
    );
  }
}

Future<String?> _showMyDialog(BuildContext context) async {
  TextEditingController roomNameController = TextEditingController();

  return showDialog<String>(
    context: context,
    barrierDismissible: false, // Prevent dismiss by tapping outside
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Add new room'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              TextField(
                controller: roomNameController, // Attach the controller here
                decoration:
                    const InputDecoration(helperText: "Enter Room Name"),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Approve'),
            onPressed: () {
              Navigator.of(context)
                  .pop(roomNameController.text); // Pass back the text
            },
          ),
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop(null); // Return null if cancelled
            },
          ),
        ],
      );
    },
  );
}
