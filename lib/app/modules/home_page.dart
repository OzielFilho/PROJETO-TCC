import 'dart:io';

import 'package:flutter/material.dart';

import 'event_volume_actions.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var value;
  @override
  void initState() {
    super.initState();
    connectToService();
  }

  Future<void> connectToService() async {
    if (Platform.isAndroid) {
      EventVolumeActions.call(arguments: {
        "phones": [
          "+5585988714838",
        ]
      }).then((value) => debugPrint('result: ' + value.toString()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //Text(_batteryLevel, key: const Key('Battery level label')),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: connectToService,
                  child: const Text('Refresh'),
                ),
              ),
            ],
          ),
          // Text(_chargingStatus),
        ],
      ),
    );
  }
}
