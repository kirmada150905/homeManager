// import 'package:flutter/material.dart';

// class DetailedRoomView extends StatefulWidget {
//   final Map<String, dynamic> room;
//   const DetailedRoomView({super.key, required this.room});

//   @override
//   State<DetailedRoomView> createState() => _DetailedRoomViewState();
// }

// class _DetailedRoomViewState extends State<DetailedRoomView> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.room["name"]),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: (widget.room.values.toList()).length > 1
//                 ? ListView.builder(
//                     itemCount: widget.room["appliances"].length,
//                     itemBuilder: (context, index) {
//                       String applianceName =
//                           widget.room["appliances"].keys.toList()[index];
//                       var appliance = widget.room["appliances"][applianceName];
//                       if (appliance.runtimeType == int) {
//                         return SwitchAppliance(
//                           appliance: {applianceName: appliance},
//                           onDelete: () => _deleteAppliance(applianceName),
//                         );
//                       } else {
//                         return SliderAppliance(
//                           appliance: {applianceName: appliance},
//                           onDelete: () => _deleteAppliance(applianceName),
//                         );
//                       }
//                     },
//                   )
//                 : const Text("Add Appliances"),
//           ),
//           SizedBox(
//             height: 250,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 ElevatedButton(
//                   child: const Text("Add Appliance"),
//                   onPressed: () {
//                     _showMyDialog(context).then((result) {
//                       if (result != null) {
//                         String applianceName = result["name"];
//                         int controlType = result["controlType"];

//                         setState(() {
//                           widget.room["appliances"].addEntries([
//                             MapEntry(
//                               applianceName,
//                               controlType == 1
//                                   ? 1
//                                   : {"temp": 20}, // Switch or Slider
//                             ),
//                           ]);
//                         });
//                       }
//                     });
//                   },
//                 ),
//                 ElevatedButton(
//                     onPressed: () {
//                       setState(() {
//                         widget.room["appliances"] = {};
//                       });
//                     },
//                     child: const Text("delete all"))
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _deleteAppliance(String applianceName) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Delete Appliance'),
//           content: Text('Are you sure you want to delete $applianceName?'),
//           actions: [
//             TextButton(
//               child: const Text('Cancel'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             TextButton(
//               child: const Text('Delete'),
//               onPressed: () {
//                 setState(() {
//                   widget.room["appliances"].remove(applianceName);
//                 });
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

// class SwitchAppliance extends StatefulWidget {
//   final Map<String, int> appliance;
//   final VoidCallback onDelete; // Callback for delete action
//   const SwitchAppliance(
//       {super.key, required this.appliance, required this.onDelete});

//   @override
//   State<SwitchAppliance> createState() => _SwitchApplianceState();
// }

// class _SwitchApplianceState extends State<SwitchAppliance> {
//   @override
//   Widget build(BuildContext context) {
//     bool state =
//         widget.appliance[widget.appliance.keys.toList()[0]] == 1 ? true : false;
//     return Card(
//       child: ListTile(
//         title: Text(widget.appliance.keys.toList()[0]),
//         trailing: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Switch(
//               value: state,
//               onChanged: (value) {
//                 setState(() {
//                   state = value;
//                   widget.appliance[widget.appliance.keys.toList()[0]] =
//                       value ? 1 : 0;
//                 });
//               },
//             ),
//             IconButton(
//               icon: const Icon(Icons.delete, color: Colors.grey),
//               onPressed: widget.onDelete, // Calls the delete function
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class SliderAppliance extends StatefulWidget {
//   final Map<String, dynamic> appliance;
//   final VoidCallback onDelete; // Callback for delete action
//   const SliderAppliance(
//       {super.key, required this.appliance, required this.onDelete});

//   @override
//   State<SliderAppliance> createState() => _SliderApplianceState();
// }

// class _SliderApplianceState extends State<SliderAppliance> {
//   double currentSliderValue = 20;
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Card(
//           child: ListTile(
//             leading: Text(widget.appliance.keys.toList()[0]),
//             title: Slider(
//               value: currentSliderValue,
//               max: 100,
//               divisions: 100,
//               label: currentSliderValue.round().toString(),
//               onChanged: (double value) {
//                 setState(() {
//                   currentSliderValue = value;
//                   widget.appliance[widget.appliance.keys.toList()[0]] = {
//                     "temp": currentSliderValue
//                   };
//                 });
//               },
//             ),
//             trailing: IconButton(
//               icon: const Icon(Icons.delete, color: Colors.grey),
//               onPressed: widget.onDelete, // Calls the delete function
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// Future<Map<String, dynamic>?> _showMyDialog(BuildContext context) async {
//   TextEditingController applianceNameController = TextEditingController();
//   int? selectedControl; // To store the selected control type
//   return showDialog<Map<String, dynamic>>(
//     context: context,
//     barrierDismissible: false,
//     builder: (BuildContext context) {
//       return StatefulBuilder(
//         builder: (BuildContext context, StateSetter setState) {
//           return AlertDialog(
//             title: const Text('Add new appliance'),
//             content: SingleChildScrollView(
//               child: ListBody(
//                 children: <Widget>[
//                   TextField(
//                     controller: applianceNameController,
//                     decoration: const InputDecoration(
//                         helperText: "Enter Appliance Name"),
//                   ),
//                   const SizedBox(height: 10),
//                   const Text("Select Device Control"),
//                   DropdownMenu<int>(
//                     initialSelection: selectedControl,
//                     dropdownMenuEntries: const [
//                       DropdownMenuEntry(
//                         value: 1,
//                         label: "Switch Control",
//                         labelWidget: Text("Switch Control"),
//                       ),
//                       DropdownMenuEntry(
//                         value: 2,
//                         label: "Slider Control",
//                         labelWidget: Text("Slider Control"),
//                       ),
//                     ],
//                     onSelected: (int? value) {
//                       setState(() {
//                         selectedControl = value;
//                       });
//                     },
//                   ),
//                 ],
//               ),
//             ),
//             actions: <Widget>[
//               TextButton(
//                 child: const Text('Approve'),
//                 onPressed: () {
//                   if (applianceNameController.text.isNotEmpty &&
//                       selectedControl != null) {
//                     Navigator.of(context).pop({
//                       "name": applianceNameController.text,
//                       "controlType": selectedControl
//                     });
//                   } else {
//                     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//                       content: Text("Please fill all fields"),
//                     ));
//                   }
//                 },
//               ),
//               TextButton(
//                 child: const Text('Cancel'),
//                 onPressed: () {
//                   Navigator.of(context).pop(null);
//                 },
//               ),
//             ],
//           );
//         },
//       );
//     },
//   );
// }
import 'package:flutter/material.dart';

class DetailedRoomView extends StatefulWidget {
  final Map<String, dynamic> room;

  const DetailedRoomView({super.key, required this.room});

  @override
  State<DetailedRoomView> createState() => _DetailedRoomViewState();
}

class _DetailedRoomViewState extends State<DetailedRoomView> {
  late Map<String, dynamic> appliances;

  @override
  void initState() {
    super.initState();
    // Ensure appliances map is initialized
    appliances = widget.room["appliances"] ?? {};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.room["name"]),
      ),
      body: Column(
        children: [
          Expanded(
            child: appliances.isNotEmpty
                ? ListView.builder(
                    itemCount: appliances.length,
                    itemBuilder: (context, index) {
                      String applianceName = appliances.keys.toList()[index];
                      var appliance = appliances[applianceName];
                      if (appliance.runtimeType == int) {
                        return SwitchAppliance(
                          appliance: {applianceName: appliance},
                          onDelete: () => _deleteAppliance(applianceName),
                        );
                      } else {
                        return SliderAppliance(
                          appliance: {applianceName: appliance},
                          onDelete: () => _deleteAppliance(applianceName),
                        );
                      }
                    },
                  )
                : const Center(child: Text("No Appliances. Add some!")),
          ),
          SizedBox(
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  child: const Text("Add Appliance"),
                  onPressed: () {
                    _showMyDialog(context).then((result) {
                      if (result != null) {
                        String applianceName = result["name"];
                        int controlType = result["controlType"];

                        setState(() {
                          appliances[applianceName] = controlType == 1
                              ? 1
                              : {"temp": 20}; // Switch or Slider
                        });
                      }
                    });
                  },
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      appliances.clear();
                    });
                  },
                  child: const Text("Delete All"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _deleteAppliance(String applianceName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Appliance'),
          content: Text('Are you sure you want to delete $applianceName?'),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                setState(() {
                  appliances.remove(applianceName);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class SwitchAppliance extends StatefulWidget {
  final Map<String, int> appliance;
  final VoidCallback onDelete;

  const SwitchAppliance({
    super.key,
    required this.appliance,
    required this.onDelete,
  });

  @override
  State<SwitchAppliance> createState() => _SwitchApplianceState();
}

class _SwitchApplianceState extends State<SwitchAppliance> {
  @override
  Widget build(BuildContext context) {
    bool state =
        widget.appliance[widget.appliance.keys.toList()[0]] == 1 ? true : false;
    return Card(
      child: ListTile(
        title: Text(widget.appliance.keys.toList()[0]),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Switch(
              value: state,
              onChanged: (value) {
                setState(() {
                  state = value;
                  widget.appliance[widget.appliance.keys.toList()[0]] =
                      value ? 1 : 0;
                });
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.grey),
              onPressed: widget.onDelete,
            ),
          ],
        ),
      ),
    );
  }
}

class SliderAppliance extends StatefulWidget {
  final Map<String, dynamic> appliance;
  final VoidCallback onDelete;

  const SliderAppliance({
    super.key,
    required this.appliance,
    required this.onDelete,
  });

  @override
  State<SliderAppliance> createState() => _SliderApplianceState();
}

class _SliderApplianceState extends State<SliderAppliance> {
  double currentSliderValue = 20;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: ListTile(
            leading: Text(widget.appliance.keys.toList()[0]),
            title: Slider(
              value: currentSliderValue,
              max: 100,
              divisions: 100,
              label: currentSliderValue.round().toString(),
              onChanged: (double value) {
                setState(() {
                  currentSliderValue = value;
                  widget.appliance[widget.appliance.keys.toList()[0]] = {
                    "temp": currentSliderValue
                  };
                });
              },
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.grey),
              onPressed: widget.onDelete,
            ),
          ),
        ),
      ],
    );
  }
}

Future<Map<String, dynamic>?> _showMyDialog(BuildContext context) async {
  TextEditingController applianceNameController = TextEditingController();
  int? selectedControl;

  return showDialog<Map<String, dynamic>>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            title: const Text('Add new appliance'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  TextField(
                    controller: applianceNameController,
                    decoration: const InputDecoration(
                      helperText: "Enter Appliance Name",
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text("Select Device Control"),
                  DropdownMenu<int>(
                    initialSelection: selectedControl,
                    dropdownMenuEntries: const [
                      DropdownMenuEntry(
                        value: 1,
                        label: "Switch Control",
                        labelWidget: Text("Switch Control"),
                      ),
                      DropdownMenuEntry(
                        value: 2,
                        label: "Slider Control",
                        labelWidget: Text("Slider Control"),
                      ),
                    ],
                    onSelected: (int? value) {
                      setState(() {
                        selectedControl = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Approve'),
                onPressed: () {
                  if (applianceNameController.text.isNotEmpty &&
                      selectedControl != null) {
                    Navigator.of(context).pop({
                      "name": applianceNameController.text,
                      "controlType": selectedControl,
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Please fill all fields"),
                    ));
                  }
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
    },
  );
}
