import 'package:pockett/graphs/barchart.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'package:flutter/material.dart';
import 'package:pockett/graphs/linechart.dart';
import 'package:pockett/graphs/piechart.dart';

class LineChart1 extends StatelessWidget {
  final List<IncomeAmt2> data;

  LineChart1({@required this.data});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<IncomeAmt2, String>> series2 = [
      charts.Series(
          id: "Chart2",
          data: data,
          domainFn: (IncomeAmt2 series2, _) => series2.date,
          measureFn: (IncomeAmt2 series2, _) => series2.amt,
          colorFn: (IncomeAmt2 series2, _) => series2.lineColor)
    ];
    return Container(
      height: 300,
      padding: EdgeInsets.all(10),
      child: Card(
          child: Padding(
        padding: EdgeInsets.all(5),
        child: Column(children: <Widget>[
          Expanded(
            child: charts.PieChart(series2,
                animate: true,
                defaultRenderer: new charts.ArcRendererConfig(arcWidth: 60)),
          ),
        ]),
      )),
    );
  }
}
