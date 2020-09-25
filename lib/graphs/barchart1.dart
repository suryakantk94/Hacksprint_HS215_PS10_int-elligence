import 'package:pockett/graphs/barchart.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'package:flutter/material.dart';

class BarChart1 extends StatelessWidget {
  final List<IncomeAmt> data;

  BarChart1({@required this.data});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<IncomeAmt, String>> series = [
      charts.Series(
          id: "Chart",
          data: data,
          domainFn: (IncomeAmt series, _) => series.date,
          measureFn: (IncomeAmt series, _) => series.amt,
          colorFn: (IncomeAmt series, _) => series.barColor)
    ];
    return Container(
      height: 300,
      padding: EdgeInsets.all(10),
      child: Card(
          child: Padding(
        padding: EdgeInsets.all(5),
        child: Column(children: <Widget>[
          Expanded(
            child: charts.BarChart(
              series,
              animate: true,
            ),
          ),
        ]),
      )),
    );
  }
}
