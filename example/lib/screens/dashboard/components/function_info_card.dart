import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial_example/ChatPage.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';
import '../../../models/Functions.dart';
import '../../manual_drive.dart';
import '../../recent_device.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import '../../voice_drive.dart';

class FunctionInfoCard extends StatelessWidget {
  late BluetoothDevice server;
  FunctionInfoCard(
      {Key? key, required this.info, required this.index, required this.server})
      : super(key: key);

  final FunctionInfo info;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          switch (index) {
            case 0:
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ManualDrive(server: this.server),
              ));
              break;
            case 1:
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => VoiceDrive(server: this.server),
              ));
              break;
            case 2:
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => RecentDevice(),
              ));
              break;
            case 3:
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ChatPage(server: this.server),
              ));
              break;
            default:
          }
        }, // Handle your callback
        child: Container(
          padding: EdgeInsets.all(defaultPadding),
          decoration: BoxDecoration(
            color: secondaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(defaultPadding * 0.75),
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  color: info.color!.withOpacity(0.1),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: SvgPicture.asset(
                  info.svgSrc!,
                  height: 30,
                  width: 30,
                  color: info.color,
                ),
              ),
              Text(
                info.title!,
                maxLines: 1,
                style: TextStyle(fontSize: 14),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ));
  }
}
