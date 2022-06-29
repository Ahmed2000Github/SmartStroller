import 'dart:convert';
import 'dart:typed_data';

import 'package:control_button/control_button.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import '../constants.dart';

class ManualDrive extends StatefulWidget {
  late BluetoothDevice server;

  ManualDrive({required this.server});
  @override
  State<StatefulWidget> createState() {
    return Content();
  }
}

class Content extends State<ManualDrive> {
  BluetoothConnection? connection;

  final TextEditingController textEditingController =
      new TextEditingController();
  final ScrollController listScrollController = new ScrollController();

  bool isConnecting = true;
  bool get isConnected => (connection?.isConnected ?? false);

  bool isDisconnecting = false;

  @override
  void initState() {
    super.initState();

    BluetoothConnection.toAddress(widget.server.address).then((_connection) {
      print('Connected to the device');
      connection = _connection;
      setState(() {
        isConnecting = false;
        isDisconnecting = false;
      });

      connection!.input!.listen(null).onDone(() {
        if (isDisconnecting) {
          print('Disconnecting locally!');
        } else {
          print('Disconnected remotely!');
        }
        if (this.mounted) {
          setState(() {});
        }
      });
    }).catchError((error) {
      print('Cannot connect, exception occured');
      print(error);
    });
  }

  @override
  void dispose() {
    // Avoid memory leak (`setState` after dispose) and disconnect
    if (isConnected) {
      isDisconnecting = true;
      connection?.dispose();
      connection = null;
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final serverName = widget.server.name ?? "Unknown";
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: secondaryColor,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
            ),
            title: Text(
              'Manual Drive' +
                  (isConnected
                      ? ' (connecter a ' + serverName + ')'
                      : ' (attend la connection ...)'),
              style: TextStyle(fontSize: 20),
            ),
            backgroundColor: secondaryColor,
          ),
          body: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "gliss finger over\n button to move to ",
                style: TextStyle(fontSize: 23, color: Colors.white),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              ControlButton(
                sectionOffset: FixedAngles.Inclined120,
                externalDiameter: 300,
                internalDiameter: 120,
                dividerColor: Colors.blue,
                elevation: 4,
                externalColor: Colors.lightBlue[100],
                internalColor: Colors.grey[300],
                mainAction: () {
                  updateState('S');
                  return 1.1;
                },
                sections: [
                  () {
                    updateState('B');
                    return 1.1;
                  },
                  () {
                    updateState('R');
                    return 1.1;
                  },
                  () {
                    updateState('F');
                    return 1.1;
                  },
                  () {
                    updateState('L');
                    return 1.1;
                  },
                ],
              ),
            ],
          ))),
    );
  }

  updateState(String text) async {
    text = text.trim();

    if (text.length > 0) {
      try {
        connection!.output.add(Uint8List.fromList(utf8.encode(text + "\r\n")));
        await connection!.output.allSent;
        print("teseseseese  " + text);

        Future.delayed(Duration(milliseconds: 333)).then((_) {
          listScrollController.animateTo(
              listScrollController.position.maxScrollExtent,
              duration: Duration(milliseconds: 333),
              curve: Curves.easeOut);
        });
      } catch (e) {
        // Ignore error, but notify state
        setState(() {});
      }
    }
  }
}
