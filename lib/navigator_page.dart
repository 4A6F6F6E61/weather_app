import 'dart:developer' as dev;

import 'package:weather_app/components/add_location_dialog.dart';
import 'package:weather_app/models/location.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GlobalKey<ScaffoldState> navigatorScaffoldKey = GlobalKey<ScaffoldState>();

class NavigatorPage extends StatefulWidget {
  const NavigatorPage({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<NavigatorPage> createState() => _NavigatorPageState();
}

class _NavigatorPageState extends State<NavigatorPage> {
  List<Location> locations = [];

  @override
  void initState() {
    super.initState();
    asyncInit();
  }

  Future<void> asyncInit() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLocations = prefs.getStringList('locations') ?? [];

    for (final locationString in savedLocations) {
      try {
        locations.add(Location.fromString(locationString));
      } catch (e) {
        dev.log(
          'Failed to parse Location from string: $locationString',
          name: 'NavigatorPage::initState',
        );
        continue;
      }
    }
    setState(() {});
  }

  Future<void> addLocation() async {
    final result = await showDialog<Location?>(
      context: context,
      builder: (_) {
        return AddLocationDialog();
      },
    );

    if (result == null) {
      return;
    }

    try {
      if (locations.any((location) => location.toString() == result.toString())) {
        dev.log(
          'Location ${result.name} is already in the list.',
          name: 'NavigatorPage::addLocation',
        );
        return;
      }
      setState(() {
        locations.add(result);
      });
      final prefs = await SharedPreferences.getInstance();
      final locationStrings = locations.map((locations) => locations.toString()).toList();
      await prefs.setStringList('locations', locationStrings);
    } catch (e) {
      dev.log('Error adding location $result: $e', name: 'NavigatorPage::addLocation');
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: navigatorScaffoldKey,
      body: widget.navigationShell,
      drawer: NavigationDrawer(
        header: Padding(
          padding: const EdgeInsets.fromLTRB(28, 16, 16, 10),
          child: Text('Weather App', style: Theme.of(context).textTheme.titleMedium),
        ),
        children: [
          // The default navigation drawer items are a bit janky and I want more control
          // over the logic, so I'm just using InkWell's here.
          InkWell(
            onTap: () {
              context.pop();
              context.go('/home');
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(Icons.home),
                  const SizedBox(width: 10),
                  Text('Home', style: Theme.of(context).textTheme.bodyLarge),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 28, right: 6, top: 16, bottom: 10),
            child: Row(
              children: [
                SizedBox(width: 20, child: Divider()),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: Text('Saved Locations', style: Theme.of(context).textTheme.titleMedium),
                ),
                Expanded(child: Divider()),
                IconButton.filledTonal(onPressed: addLocation, icon: Icon(Icons.add)),
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: locations.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  context.pop();
                  context.go('/home/${locations[index].toString()}');
                  dev.log(
                    'Navigating to /home/${locations[index].toString()}',
                    name: 'NavigatorPage::onTap',
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Text(locations[index].name, style: Theme.of(context).textTheme.bodyLarge),
                    ],
                  ),
                ),
              );
            },
          ),
          locations.isEmpty
              ? SizedBox()
              : const Padding(
                  padding: EdgeInsets.only(left: 28, right: 28, top: 16, bottom: 10),
                  child: Divider(),
                ),
          InkWell(
            onTap: () {
              context.pop();
              context.go('/about');
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(Icons.info),
                  const SizedBox(width: 10),
                  Text('About', style: Theme.of(context).textTheme.bodyLarge),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
