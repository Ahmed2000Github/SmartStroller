import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'chart.dart';

class BattryStatus extends StatefulWidget {
  const BattryStatus({
    Key? key,
  }) : super(key: key);

  
  @override
  State<StatefulWidget> createState() {
    return Con();
  }
}

class Con extends State<BattryStatus>  {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      // ignore: prefer_const_constructors
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
                 Text(
            "Etat de battrie",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            
          ),
            ],
          ),
                 
          SizedBox(height: defaultPadding),
          Chart(),
        ],
      ),
    );
  }

}
