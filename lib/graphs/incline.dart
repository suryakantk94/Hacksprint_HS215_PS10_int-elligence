import 'package:flutter/material.dart';
import 'package:pockett/animation/FadeAnimation.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:pockett/graphs/barchart.dart';
import 'package:pockett/graphs/barchart1.dart';
import 'package:pockett/graphs/linechart.dart';
import 'package:pockett/graphs/linechart1.dart';

class Expenseline extends StatefulWidget {
  @override
  _ExpenselineState createState() => _ExpenselineState();
}

class _ExpenselineState extends State<Expenseline> {
  final List<IncomeAmt2> data = [
    IncomeAmt2(
      date: "30 June",
      amt: 20,
      lineColor: charts.ColorUtil.fromDartColor(Colors.blue[500]),
    ),
    IncomeAmt2(
      date: "1 July",
      amt: 35,
      lineColor: charts.ColorUtil.fromDartColor(Colors.red),
    ),
    IncomeAmt2(
      date: "2 July",
      amt: 10,
      lineColor: charts.ColorUtil.fromDartColor(Colors.yellow),
    ),
    IncomeAmt2(
      date: "3 July",
      amt: 18,
      lineColor: charts.ColorUtil.fromDartColor(Colors.orange),
    ),
    IncomeAmt2(
      date: "4 July",
      amt: 40,
      lineColor: charts.ColorUtil.fromDartColor(Colors.green),
    ),
    IncomeAmt2(
      date: "5 July",
      amt: 30,
      lineColor: charts.ColorUtil.fromDartColor(Colors.indigo),
    ),
    IncomeAmt2(
      date: "6 July",
      amt: 20,
      lineColor: charts.ColorUtil.fromDartColor(Colors.teal),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Colors.blue[900],
          Colors.blue[800],
          Colors.blue[400]
        ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: SingleChildScrollView(
                    child: FadeAnimation(
                        1.4,
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromRGBO(20, 17, 237, .4),
                                    blurRadius: 20,
                                    offset: Offset(0, 10))
                              ]),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    height: 350,
                                    width: 600,
                                    child: LineChart1(data: data)),
                              ]),
                        )),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
