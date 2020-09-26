import 'package:flutter/material.dart';
import 'package:pockett/animation/FadeAnimation.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:pockett/graphs/barchart.dart';
import 'package:pockett/graphs/barchart1.dart';
import 'package:pockett/graphs/linechart.dart';
import 'package:pockett/graphs/linechart1.dart';
import '../handlers/database-manager.dart';
import '../entities/DateExpense.dart';
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'dart:math';
class Expenseline extends StatefulWidget {
  @override
  _ExpenselineState createState() => _ExpenselineState();
}

class _ExpenselineState extends State<Expenseline> {
  final List<IncomeAmt2> staticData = [
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
  void initState() {
    super.initState();
    //timer =
    //new Timer.periodic(new Duration(seconds: 15), (t) => getExpenseData());
    getExpenseData();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  Timer timer;
  List data;
  handleGetDataSuccess(String response) {
    setState(() {
      data = jsonDecode(response);
    });
  }

  getExpenseData() async {
    Future<dynamic> loginFuture = DBManager.db.getExpenses();
    loginFuture
        .then((data) => {handleGetDataSuccess(data)})
        .catchError((err) => {print("Error getting data")});
  }

  createChart() {
    var newFormat = DateFormat("dd MMM");
    print(data);
    //List<DateExpense> apiData = List<DateExpense>.from(data).map((Map model) => DateExpense.fromJson(model)).toList();
    List<DateExpense> apiData =
    data.map((dJson) => DateExpense.fromJson(dJson)).toList();
    print(apiData);
    apiData.sort((a, b) => a.date.compareTo(b.date));
    Random random = new Random();
    List<IncomeAmt2> modifiedData = apiData
        .map((s) =>
    new IncomeAmt2(
        date: newFormat.format(s.date),
        amt: s.total.round(),

        lineColor: charts.ColorUtil.fromDartColor(Color.fromARGB(
            255, random.nextInt(255), random.nextInt(255),
            random.nextInt(255)))))
        .toList();

    List<charts.Series<IncomeAmt2, String>> series1 = [
      charts.Series(
          id: "Chart1",
          data: modifiedData,
          domainFn: (IncomeAmt2 series1, _) => series1.date,
          measureFn: (IncomeAmt2 series1, _) => series1.amt,
          colorFn: (IncomeAmt2 series1, _) => series1.lineColor)
    ];

    print("\n\n\n\t\t\t");
    print(modifiedData);
    //l.add(12);

    return Container(
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
                                  child: LineChart1(data: modifiedData)),
                            ]),
                      )),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: data == null
              ? Container(child: CircularProgressIndicator())
              : createChart(),
        ));
  }
}
