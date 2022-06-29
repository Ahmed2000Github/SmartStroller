import 'package:flutter/material.dart';
import 'components/side_menu.dart';
import 'components/functions.dart';

import '../../constants.dart';

import 'components/battry_satus.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class DashboardScreen extends StatefulWidget {
  late BluetoothDevice server;
  DashboardScreen({Key? key, required this.server}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return Conte();
  }
}

class Conte extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          backgroundColor: secondaryColor,
          title: Text(
            'Smart Stroller',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
        ),
        drawer: SideMenu(),
        body: Container(
          color: bgColor,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(defaultPadding),
            child: Column(
              children: [
                // const Header(),
                const SizedBox(height: defaultPadding),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 5,
                      child: Column(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          const BattryStatus(),
                          const SizedBox(height: defaultPadding),
                          MyFunctions(
                            server: widget.server,
                          ),
                          const SizedBox(height: defaultPadding),
                          // RecentFiles(),
                        ],
                      ),
                    ),
                    const SizedBox(width: defaultPadding),
                    // On Mobile means if the screen is less than 850 we dont want to show it
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
