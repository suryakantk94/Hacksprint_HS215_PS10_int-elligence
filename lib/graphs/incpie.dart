import 'package:flutter/material.dart';
import 'package:pockett/animation/FadeAnimation.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:pockett/graphs/barchart.dart';
import 'package:pockett/graphs/barchart1.dart';
import 'package:pockett/graphs/piechart.dart';
import 'package:pockett/graphs/piechart1.dart';
import '../handlers/database-manager.dart';
import '../entities/DateExpense.dart';
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'dart:math';
class Expensechart extends StatefulWidget {
  @override
  _ExpensechartState createState() => _ExpensechartState();
}

class _ExpensechartState extends State<Expensechart> {
  final List<IncomeAmt1> staticData = [
    IncomeAmt1(
      date: "30 June",
      amt: 20,
      pieColor: charts.ColorUtil.fromDartColor(Colors.blue[500]),
    ),
    IncomeAmt1(
      date: "1 July",
      amt: 35,
      pieColor: charts.ColorUtil.fromDartColor(Colors.red),
    ),
    IncomeAmt1(
      date: "2 July",
      amt: 10,
      pieColor: charts.ColorUtil.fromDartColor(Colors.yellow),
    ),
    IncomeAmt1(
      date: "3 July",
      amt: 18,
      pieColor: charts.ColorUtil.fromDartColor(Colors.orange),
    ),
    IncomeAmt1(
      date: "4 July",
      amt: 40,
      pieColor: charts.ColorUtil.fromDartColor(Colors.green),
    ),
    IncomeAmt1(
      date: "5 July",
      amt: 30,
      pieColor: charts.ColorUtil.fromDartColor(Colors.indigo),
    ),
    IncomeAmt1(
      date: "6 July",
      amt: 20,
      pieColor: charts.ColorUtil.fromDartColor(Colors.teal),
    ),
  ];



  @override
  void initState() {
    super.initState();
    timer =
    new Timer.periodic(new Duration(seconds: 2), (t) => getExpenseData());
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
    Random random = new Random();
    List<IncomeAmt1> modifiedData = apiData
        .map((s) => new IncomeAmt1(
        date: newFormat.format(s.date),
        amt: s.total.round(),

        pieColor: charts.ColorUtil.fromDartColor(Color.fromARGB(
               255, random.nextInt(255), random.nextInt(255), random.nextInt(255)))))
        .toList();

    List<charts.Series<IncomeAmt1, String>> series1 = [
      charts.Series(
          id: "Chart1",
          data: modifiedData,
          domainFn: (IncomeAmt1 series1, _) => series1.date,
          measureFn: (IncomeAmt1 series1, _) => series1.amt,
          colorFn: (IncomeAmt1 series1, _) => series1.pieColor)
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
                                  child: PieChart1(data: modifiedData)),
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
      body: data == null ? CircularProgressIndicator() : createChart(),
    );
  }

}
