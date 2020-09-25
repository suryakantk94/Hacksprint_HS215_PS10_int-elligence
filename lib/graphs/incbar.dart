import 'package:flutter/material.dart';
import 'package:pockett/animation/FadeAnimation.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:pockett/graphs/barchart.dart';
import 'package:pockett/graphs/barchart1.dart';

class Incomegraph extends StatefulWidget {
  @override
  _IncomegraphState createState() => _IncomegraphState();
}

class _IncomegraphState extends State<Incomegraph> {
  final List<IncomeAmt> data = [
    IncomeAmt(
      date: "30 June",
      amt: 20,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue[500]),
    ),
    IncomeAmt(
      date: "1 July",
      amt: 35,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue[500]),
    ),
    IncomeAmt(
      date: "2 July",
      amt: 10,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue[500]),
    ),
    IncomeAmt(
      date: "3 July",
      amt: 18,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue[500]),
    ),
    IncomeAmt(
      date: "4 July",
      amt: 40,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue[500]),
    ),
    IncomeAmt(
      date: "5 July",
      amt: 30,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue[500]),
    ),
    IncomeAmt(
      date: "6 July",
      amt: 20,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue[500]),
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
            SizedBox(
              height: 80,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeAnimation(
                      1,
                      Text(
                        "Income Analysis",
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  FadeAnimation(
                      1.3,
                      Text(
                        "Bar Graph",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 40,
                      ),
                      FadeAnimation(
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
                                      height: 450,
                                      width: 600,
                                      child: BarChart1(data: data)),
                                ]),
                          )),
                    ],
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
