import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class Chart extends StatefulWidget {
  const Chart({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _Chart();
  }
}

class _Chart extends State<Chart> {
  late List<PieChartSectionData> paiChartSelectionDatas;
  late double counter = 0;
  Timer? timer;
  @override
  void initState() {
    paiChartSelectionDatas = [
      PieChartSectionData(
        color: Color(0xFF26E5FF),
        value: 100 - 54,
        showTitle: false,
        radius: 22,
      ),
      PieChartSectionData(
        color: primaryColor,
        value: 54,
        showTitle: false,
        radius: 25,
      )
    ];
    timer = Timer.periodic(
        Duration(seconds: 2), (Timer t) => checkForNewSharedLists());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          PieChart(
            PieChartData(
              sectionsSpace: 0,
              centerSpaceRadius: 70,
              startDegreeOffset: -90,
              sections: paiChartSelectionDatas,
            ),
          ),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: defaultPadding),
                Text(
                  paiChartSelectionDatas.elementAt(1).value.toString() + '%',
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        height: 0.5,
                      ),
                ),
                Text("of 100%")
              ],
            ),
          ),
        ],
      ),
    );
  }

  checkForNewSharedLists() {
    setState(() {
      paiChartSelectionDatas = [
        PieChartSectionData(
          color: Color.fromARGB(255, 71, 255, 38),
          value: 100 - counter,
          showTitle: false,
          radius: 22,
        ),
        PieChartSectionData(
          color: primaryColor,
          value: counter,
          showTitle: false,
          radius: 25,
        )
      ];
    });
    if (counter == 100) {
      counter = 0;
    } else {
      counter += 10;
    }
  }
}
