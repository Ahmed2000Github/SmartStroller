import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../../models/Functions.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'function_info_card.dart';

class MyFunctions extends StatefulWidget {
  late BluetoothDevice server;
  MyFunctions({Key? key, required this.server}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return Cont();
  }
}

class Cont extends State<MyFunctions> {
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Functionalities",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ],
        ),
        const SizedBox(height: defaultPadding),
        FunctionInfoCardGridView(
          crossAxisCount: _size.width < 650 ? 2 : 4,
          childAspectRatio: _size.width < 650 ? 1.3 : 1,
          server: widget.server,
        ),
      ],
    );
  }
}

class FunctionInfoCardGridView extends StatelessWidget {
  late BluetoothDevice server;

  FunctionInfoCardGridView(
      {Key? key,
      this.crossAxisCount = 4,
      this.childAspectRatio = 1,
      required this.server})
      : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: functionalities.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: defaultPadding,
          mainAxisSpacing: defaultPadding,
          childAspectRatio: childAspectRatio,
        ),
        itemBuilder: (context, index) => FunctionInfoCard(
              info: functionalities[index],
              index: index,
              server: this.server,
            ));
  }
}
