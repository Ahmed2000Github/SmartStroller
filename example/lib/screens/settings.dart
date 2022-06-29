import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return Content();
  }
}

class Content extends State<Setting> {
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
            'Settings',
            style: TextStyle(fontSize: 20),
          ),
          backgroundColor: secondaryColor,
        ),
        body: Column(
          children: [
            TextButton(
                onPressed: () => {},
                child: Text(
                  "test",
                  style: TextStyle(fontSize: 20, color: Colors.red),
                )),
            Container(
              child: Row(),
            )
          ],
        ),
      ),
    );
  }
}
