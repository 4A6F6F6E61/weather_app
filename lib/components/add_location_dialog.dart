import 'dart:developer' as dev;

import 'package:weather_app/models/location.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/api.dart' as api;

class AddLocationDialog extends StatefulWidget {
  const AddLocationDialog({super.key});

  @override
  State<AddLocationDialog> createState() => _AddLocationDialogState();
}

class _AddLocationDialogState extends State<AddLocationDialog> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  List<Location> suggestions = [];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Location'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: 'Search for a location'),
            autofocus: true,
            onChanged: (String value) async {
              final result = await api.search(value);
              dev.log('Search results: $result', name: 'AddLocationDialog');

              setState(() {
                suggestions = result;
              });
            },
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 200,
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (controller.text.isEmpty)
                    Center(child: const Text("Please enter a search term."))
                  else if (suggestions.isEmpty)
                    Center(child: const Text("No suggestions found."))
                  else
                    ...suggestions.map(
                      (location) => ListTile(
                        title: Text(location.name),
                        subtitle: Text('Lat: ${location.latitude}, Lon: ${location.longitude}'),
                        onTap: () {
                          Navigator.of(context).pop(location);
                        },
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
