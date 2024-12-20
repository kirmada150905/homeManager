import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:home_manager/main.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, dynamic> jsonData = {
    "items": [
      {"name": "Living room"}
    ]
  };

  @override
  void initState() {
    super.initState();
    readJsonFile();
  }

  //port 8080
  Future<http.Response> getData() {
    return http.get(Uri.parse('http://${server}/getData'));
  }

  Future<http.Response> sendData() {
    return http.post(Uri.parse("http://${server}add_new_room"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(jsonData));
  }

  Future<void> readJsonFile() async {
    try {
      final response = await getData();

      if (response.statusCode == 200) {
        jsonData = jsonDecode(response.body);
        setState(() {});
      }
    } catch (e) {
      jsonData = {
        "items": [
          {"name": "Living room"}
        ]
      };
    }
  }

  bool isDarkMode = false;

  void toggleDarkMode(bool value) {
    setState(() {
      isDarkMode = value;
    });
  }

  bool _viewKind = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Home Page"),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  _viewKind = !_viewKind;
                });
              },
              icon: _viewKind
                  ? const Icon(Icons.view_headline_sharp)
                  : const Icon(Icons.grid_view_rounded)),
          PopupMenuButton(
            itemBuilder: (context) => [
              const PopupMenuItem(value: 1, child: Text("Settings")),
              const PopupMenuItem(value: 2, child: Text("Info")),
              const PopupMenuItem(value: 3, child: Text("Sign Out")),
            ],
            onSelected: (value) {
              if (value == 1) {
                (context).push('/settings');
              } else if (value == 2) {
                (context).push('/info_page');
              } else if (value == 3) {
                (context).go('/login');
              }
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            jsonData.isNotEmpty
                ? Expanded(
                    child: _viewKind
                        ? Container(
                            margin: EdgeInsets.all(10),
                            child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 10.0,
                                mainAxisSpacing: 10.0,
                                childAspectRatio: 1.0,
                              ),
                              itemCount: jsonData["items"].length,
                              itemBuilder: (context, index) {
                                return RoomTile(
                                  room: jsonData["items"][index],
                                  viewKind: _viewKind,
                                  onDelete: () {
                                    setState(() {
                                      jsonData["items"].removeAt(index);
                                      sendData();
                                    });
                                  },
                                );
                              },
                            ),
                          )
                        : ListView.builder(
                            itemCount: jsonData["items"].length,
                            itemBuilder: (context, index) {
                              return RoomTile(
                                room: jsonData["items"][index],
                                viewKind: _viewKind,
                                onDelete: () {
                                  setState(() {
                                    jsonData["items"].removeAt(index);
                                    print(jsonData);
                                    sendData();
                                  });
                                },
                              );
                            },
                          ),
                  )
                : const Text("Rrefersh"),
            Container(
              margin: EdgeInsets.only(right: 50, bottom: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 75,
                    height: 75,
                    child: FloatingActionButton(
                      onPressed: () {
                        _showMyDialog(context).then((newRoomName) {
                          setState(() {
                            if (newRoomName != null) {
                              jsonData["items"].add({"name": newRoomName});
                              sendData();
                            }
                          });
                        });
                      },
                      mini: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: const Icon(
                        Icons.add,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}

class RoomTile extends StatefulWidget {
  final Map<String, dynamic> room;
  final bool viewKind;
  final VoidCallback onDelete;

  const RoomTile({
    super.key,
    required this.room,
    required this.viewKind,
    required this.onDelete,
  });

  @override
  State<RoomTile> createState() => _RoomTileState();
}

class _RoomTileState extends State<RoomTile> {
  @override
  Widget build(BuildContext context) {
    return widget.viewKind
        ? GestureDetector(
            onTap: () {
              context.push('/detailed_room_view', extra: widget.room);
            },
            child: Card(
              elevation: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.room["name"],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: widget.onDelete,
                        icon: const Icon(Icons.delete, color: Colors.grey),
                      ),
                      const Icon(Icons.arrow_forward_ios),
                    ],
                  ),
                ],
              ),
            ),
          )
        : GestureDetector(
            onTap: () {
              context.push('/detailed_room_view', extra: widget.room);
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Card(
                child: ListTile(
                  title: Text(widget.room["name"]),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: widget.onDelete,
                        icon: const Icon(Icons.delete, color: Colors.grey),
                      ),
                      const Icon(Icons.arrow_forward_ios),
                    ],
                  ),
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
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Add new room'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              TextField(
                controller: roomNameController,
                decoration:
                    const InputDecoration(helperText: "Enter Room Name"),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Approve'),
            onPressed: () {
              Navigator.of(context).pop(roomNameController.text);
            },
          ),
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop(null);
            },
          ),
        ],
      );
    },
  );
}
