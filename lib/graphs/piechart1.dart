import 'package:pockett/graphs/barchart.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'package:flutter/material.dart';
import 'package:pockett/graphs/piechart.dart';

class PieChart1 extends StatelessWidget {
  final List<IncomeAmt1> data;

  PieChart1({@required this.data});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<IncomeAmt1, String>> series1 = [
      charts.Series(
          id: "Chart1",
          data: data,
          domainFn: (IncomeAmt1 series1, _) => series1.date,
          measureFn: (IncomeAmt1 series1, _) => series1.amt,
          colorFn: (IncomeAmt1 series1, _) => series1.pieColor)
    ];
    return Container(
      height: 300,
      padding: EdgeInsets.all(10),
      child: Card(
          child: Padding(
        padding: EdgeInsets.all(5),
        child: Column(children: <Widget>[
          Expanded(
            child: charts.PieChart(
              series1,
              animate: true,
            ),
          ),
        ]),
      )),
    );
  }
}
