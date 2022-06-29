import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_bluetooth_serial_example/constants.dart';
import 'package:flutter_bluetooth_serial_example/screens/dashboard/dashboard_screen.dart';
import './SelectBondedDevicePage.dart';

// import './helpers/LineChart.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPage createState() => new _MainPage();
}

class _MainPage extends State<MainPage> {
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;

  String _address = "...";
  String _name = "...";

  Timer? _discoverableTimeoutTimer;
  int _discoverableTimeoutSecondsLeft = 0;

  bool _autoAcceptPairingRequests = false;

  @override
  void initState() {
    super.initState();

    // Get current state
    FlutterBluetoothSerial.instance.state.then((state) {
      setState(() {
        _bluetoothState = state;
      });
    });

    Future.doWhile(() async {
      // Wait if adapter not enabled
      if ((await FlutterBluetoothSerial.instance.isEnabled) ?? false) {
        return false;
      }
      await Future.delayed(Duration(milliseconds: 0xDD));
      return true;
    }).then((_) {
      // Update the address field
      FlutterBluetoothSerial.instance.address.then((address) {
        setState(() {
          _address = address!;
        });
      });
    });

    FlutterBluetoothSerial.instance.name.then((name) {
      setState(() {
        _name = name!;
      });
    });

    // Listen for futher state changes
    FlutterBluetoothSerial.instance
        .onStateChanged()
        .listen((BluetoothState state) {
      setState(() {
        _bluetoothState = state;

        // Discoverable mode is disabled when Bluetooth gets disabled
        _discoverableTimeoutTimer = null;
        _discoverableTimeoutSecondsLeft = 0;
      });
    });
  }

  @override
  void dispose() {
    FlutterBluetoothSerial.instance.setPairingRequestHandler(null);
    _discoverableTimeoutTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: secondaryColor,
        title: const Text('Configuration Blutooth'),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.15,
            ),
            Divider(),
            ListTile(
                title: const Text(
              'Generale',
              style: TextStyle(color: frColor),
            )),
            SwitchListTile(
              activeColor: secondaryColor,
              title: const Text(
                'Activer Bluetooth',
                style: TextStyle(color: frColor),
              ),
              value: _bluetoothState.isEnabled,
              onChanged: (bool value) {
                // Do the request and update with the true value then
                future() async {
                  // async lambda seems to not working
                  if (value)
                    await FlutterBluetoothSerial.instance.requestEnable();
                  else
                    await FlutterBluetoothSerial.instance.requestDisable();
                }

                future().then((_) {
                  setState(() {});
                });
              },
            ),
            ListTile(
              title: const Text(
                'Etat de Bluetooth',
                style: TextStyle(color: frColor),
              ),
              subtitle: Text(
                _bluetoothState == BluetoothState.STATE_ON
                    ? "active"
                    : "disactive",
                style: TextStyle(color: frColor),
              ),
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: secondaryColor,
                ),
                child: const Text(
                  'Parametres',
                  style: TextStyle(color: frColor),
                ),
                onPressed: () {
                  FlutterBluetoothSerial.instance.openSettings();
                },
              ),
            ),
            ListTile(
              title: const Text(
                'Adresse locale',
                style: TextStyle(color: frColor),
              ),
              subtitle: Text(
                _address,
                style: TextStyle(color: frColor),
              ),
            ),
            ListTile(
              title: const Text(
                'Nom loacle',
                style: TextStyle(color: frColor),
              ),
              subtitle: Text(
                _name,
                style: TextStyle(color: frColor),
              ),
              onLongPress: null,
            ),
            Divider(),
            ListTile(
              title: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: secondaryColor,
                ),
                child: const Text(
                  'Connection au appareils paired ',
                  style: TextStyle(color: frColor),
                ),
                onPressed: () async {
                  final BluetoothDevice? selectedDevice =
                      await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return SelectBondedDevicePage(checkAvailability: false);
                      },
                    ),
                  );

                  if (selectedDevice != null) {
                    print('Connect -> selected ' + selectedDevice.address);
                    _startChat(context, selectedDevice);
                  } else {
                    print('Connect -> no device selected');
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _startChat(BuildContext context, BluetoothDevice server) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return DashboardScreen(server: server);
        },
      ),
    );
  }
}
