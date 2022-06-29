import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial_example/constants.dart';
import 'package:flutter_svg/svg.dart';

import '../models/RecentDevice.dart';

class RecentDevice extends StatefulWidget {
  const RecentDevice({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return Content();
  }
}

class Content extends State<RecentDevice> {
  @override
  Widget build(BuildContext context) {
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
          title: const Text(
            'Devices',
            style: TextStyle(fontSize: 20),
          ),
          backgroundColor: secondaryColor,
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(defaultPadding),
              // ignore: prefer_const_constructors
              decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Recent connected devices",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: DataTable2(
                      columnSpacing: defaultPadding,
                      // minWidth: 600,
                      columns: [
                        const DataColumn(
                          label: Text("Device Name",
                              style: TextStyle(color: Colors.white)),
                        ),
                        const DataColumn(
                          label: const Text("Date",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ],
                      rows: List.generate(
                        demoRecentDevices.length,
                        (index) =>
                            connectedDeviceDataRow(demoRecentDevices[index]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

DataRow connectedDeviceDataRow(RecentFile fileInfo) {
  return DataRow(
    cells: [
      DataCell(
        Row(
          children: [
            SvgPicture.asset(
              fileInfo.icon!,
              height: 30,
              width: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(
                fileInfo.title!,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      DataCell(Text(
        fileInfo.date!,
        style: TextStyle(color: Colors.white),
      )),
    ],
  );
}
