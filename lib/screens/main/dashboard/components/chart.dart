import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:webui/constants.dart';

class chart extends StatelessWidget {
  const chart({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 200,
        child: Stack(
          children: [
            PieChart(PieChartData(
              sections: piechartselectiondatas,
              centerSpaceRadius: 70,
            )),
            Positioned.fill(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: defaultPadding,
                ),
                Text(
                  "20.1",
                  style: Theme.of(context).textTheme.headline4.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      height: 0.5),
                ),
                Text("of 128GB")
              ],
            ))
          ],
        ));
  }
}

List<PieChartSectionData> piechartselectiondatas = [
  PieChartSectionData(
      value: 25, color: Colors.greenAccent, showTitle: false, radius: 25),
  PieChartSectionData(
      value: 22, color: Colors.redAccent, showTitle: false, radius: 22),
  PieChartSectionData(
      value: 19, color: Colors.orange, showTitle: false, radius: 19),
  PieChartSectionData(
      value: 25,
      color: primaryColor.withOpacity(.1),
      showTitle: false,
      radius: 25),
];
