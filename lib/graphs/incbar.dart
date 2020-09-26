import 'package:flutter/material.dart';
import 'package:pockett/animation/FadeAnimation.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:pockett/graphs/barchart.dart';
import 'package:pockett/graphs/barchart1.dart';
import '../handlers/database-manager.dart';
import '../entities/DateExpense.dart';
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
class Expensegraph extends StatefulWidget {
  @override
  _ExpensegraphState createState() => _ExpensegraphState();
}

class _ExpensegraphState extends State<Expensegraph> {
  final List<IncomeAmt> staticData = [
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

  List data;
  Timer timer;
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
    apiData.sort((a, b) => a.date.compareTo(b.date));
    print(apiData);
    List<IncomeAmt> modifiedData = apiData
        .map((s) => new IncomeAmt(
        date: newFormat.format(s.date),
        amt: s.total.round(),
        barColor: charts.ColorUtil.fromDartColor(Colors.blue[500])))
        .toList();


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
                                  child: BarChart1(data: modifiedData)),
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
