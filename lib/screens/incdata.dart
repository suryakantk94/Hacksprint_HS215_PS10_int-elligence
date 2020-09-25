import 'package:pockett/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:pockett/animation/FadeAnimation.dart';

class IncomeData extends StatefulWidget {
  @override
  _IncomeDataState createState() => _IncomeDataState();
}

class _IncomeDataState extends State<IncomeData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Colors.blue[900],
          Colors.blue[800],
          Colors.blue[500]
        ])),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              
              FadeAnimation(
                1,
                Container(
                  //height: double,
                  decoration: BoxDecoration(
                      color: Colors.lightBlueAccent[100],
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 15,
                      ),
                      FadeAnimation(
                          1.2,
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  //crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(),
                                        child: Icon(Icons.insert_chart, color: Colors.blue[900])),
                                        
                                    Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(),
                                        child: Text(
                                          "Income Bar Graph",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.blue[900]),
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              FadeAnimation(
                1.3,
                Container(
                  //height: double,
                  decoration: BoxDecoration(
                      color: Colors.lightBlueAccent[100],
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 15,
                      ),
                      FadeAnimation(
                          1.5,
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  //crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(),
                                        child: Icon(Icons.pie_chart, color: Colors.blue[900])),
                                    Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(),
                                        child: Text(
                                          "Income Pie Chart",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.blue[900]),
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              FadeAnimation(
                1.6,
                Container(
                  //height: double,
                  decoration: BoxDecoration(
                      color: Colors.lightBlueAccent[100],
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 15,
                      ),
                      FadeAnimation(
                          1.7,
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  //crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(),
                                        child: Icon(Icons.stacked_line_chart, color: Colors.blue[900],)),
                                    Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(),
                                        child: Text(
                                          "Income Line Graph",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.blue[900]),
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
