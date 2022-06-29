import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial_example/MainPage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import '../../../constants.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: bgColor,
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset("assets/images/logo.png"),
          ),
          DrawerListTile(
            title: "Dashboard",
            svgSrc: "assets/icons/menu_dashbord.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Location",
            svgSrc: "assets/icons/menu_tran.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Parametres",
            svgSrc: "assets/icons/menu_setting.svg",
            press: () {
              FlutterBluetoothSerial.instance.openSettings();
            },
          ),
          DrawerListTile(
            title: "Deconnecter",
            svgSrc: "assets/icons/disconnect.svg",
            press: () async {
              await FlutterBluetoothSerial.instance.requestDisable();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return MainPage();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        color: Color.fromARGB(255, 255, 255, 255),
        height: 20,
      ),
      title: Text(
        title,
        style:
            TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 20),
      ),
    );
  }
}
