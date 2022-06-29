import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../models/Functions.dart';
import 'function_info_card.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class MyFiles extends StatelessWidget {
  late BluetoothDevice server;
  MyFiles({Key? key, required this.server}) : super(key: key);

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
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ],
        ),
        const SizedBox(height: defaultPadding),
        FunctionInfoCardGridView(
          crossAxisCount: _size.width < 650 ? 2 : 4,
          childAspectRatio: _size.width < 650 && _size.width > 350 ? 1.3 : 1,
          server: this.server,
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
      physics: NeverScrollableScrollPhysics(),
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
      ),
    );
  }
}
