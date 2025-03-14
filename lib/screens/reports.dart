import 'package:pockett/graphs/incbar.dart';
import 'package:pockett/graphs/incline.dart';
import 'package:pockett/graphs/incpie.dart';
import 'package:pockett/graphs/linechart1.dart';
import 'package:pockett/screens/incdata.dart';
import 'package:pockett/screens/expdata.dart';
import 'package:pockett/screens/incexpdata.dart';
import 'package:flutter/material.dart';
import 'package:pockett/animation/FadeAnimation.dart';

class Reports extends StatefulWidget {
  @override
  _ReportsState createState() => _ReportsState();
}

class _ReportsState extends State<Reports> with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Container(
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors: [Colors.blue[900], Colors.blue[800], Colors.blue[400]])),
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
                        "Reports",
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  FadeAnimation(
                      1.3,
                      Text(
                        "Analysis of your spends",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
                child: SingleChildScrollView(
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60),
                          topRight: Radius.circular(60))),
                  child: Column(children: <Widget>[
                    Container(
                      child: new TabBar(
                        unselectedLabelColor: Colors.lightBlue,
                        labelColor: Colors.blue[900],
                        controller: _controller,
                        tabs: [
                          new Tab(
                            icon: const Icon(Icons.insert_chart),
                            text: 'Bar',
                          ),
                          new Tab(
                            icon: const Icon(Icons.pie_chart),
                            text: 'Pie',
                          ),
                          new Tab(
                            icon: const Icon(Icons.donut_large),
                            text: 'Donut',
                          ),
                        ],
                      ),
                    ),
                    Container(
                        height: 500,
                        width: 400,
                        child: TabBarView(
                          controller: _controller,
                          children: <Widget>[
                            incdata(),
                            expdata(),
                            incexpdata()
                          ],
                        )),
                  ])),
            ))
          ]),
    ));
  }
}

Widget incdata() {
  return Expensegraph();
}

Widget expdata() {
  return Expensechart();
}

Widget incexpdata() {
  return Expenseline();
}
