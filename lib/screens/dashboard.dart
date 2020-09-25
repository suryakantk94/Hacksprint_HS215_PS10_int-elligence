import 'package:pockett/animation/FadeAnimation.dart';
import 'package:pockett/screens/login.dart';
import 'package:pockett/screens/reports.dart';
import 'package:pockett/widget/expenseWidgets.dart';
import 'package:flutter/material.dart';
import 'package:pockett/screens/savings.dart';
//import 'package:expense_manger/screens/home.dart';
import '../entities/GlobalData.dart' as Globals;
class Dashboard extends StatefulWidget {
  @override
  DashboardState createState() => DashboardState();
}

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double blockSizeHorizontal;
  static double blockSizeVertical;
  static double _safeAreaHorizontal;
  static double _safeAreaVertical;
  static double safeBlockHorizontal;
  static double safeBlockVertical;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
    _safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;
  }
}

final tabs = ['Dashboard', 'Calendar', 'Reports', 'Logout'];

class DashboardState extends State<Dashboard> {
  int selectedPosition = 0;
  TextEditingController incController = TextEditingController();
  TextEditingController lmtController = TextEditingController();
  // Widget currentScreen = HomePage();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Colors.blue[900],
          Colors.blue[800],
          Colors.blue[500]
        ])),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: SizeConfig.safeBlockVertical * 5,
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
//header
                    FadeAnimation(
                        1,
                        Text(
                          "Hello, " + Globals.loggedInUser.username,
                          style: TextStyle(color: Colors.white, fontSize: 40),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    FadeAnimation(
                        1.2,
                        InkWell(
                          //monthly income
                          child: Text(
                            "Tap here to set you Monthly Income",
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                          onTap: () {
                            ExpenseWidgets.fieldDialogue(
                              context,
                              textController: incController,
                              title: "Enter Monthly Income",
                            );
                          },
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    FadeAnimation(
                        1.4,
                        InkWell(
                          //expense limit
                          child: Text(
                            "Tap here to set you Expense Limit",
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                          onTap: () {
                            ExpenseWidgets.fieldDialogue(
                              context,
                              textController: lmtController,
                              title: "Enter Daily Expense Limit",
                            );
                          },
                        )),
                  ],
                ),
              ),
              SizedBox(height: 20),
              FadeAnimation(
                1.6,
                Container(
                  width: SizeConfig.safeBlockHorizontal * 100,
                  height: 170,
                  decoration: BoxDecoration(
                      color: Colors.lightBlueAccent[100],
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      FadeAnimation(
                          1.8,
                          Container(
                            decoration: BoxDecoration(
                              //color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(),
                                        child: Text(
                                          "Monthly Income :",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.blue[900]),
                                        )),
                                    Container(

                                        padding: EdgeInsets.all(0),

                                        decoration: BoxDecoration(),
                                        child: Text(
                                          Globals.loggedInUser.monthlyIncome.toString(), //print monthly income here
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.blue[900]),
                                        )),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(),
                                        child: Text(
                                          "Balance Left     :",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.blue[900]),
                                        )),
                                    Container(
                                        padding: EdgeInsets.all(0),
                                        decoration: BoxDecoration(),
                                        child: Text(
                                          "       {balance left}", //print balance left here
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.blue[900]),
                                        )),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(),
                                        child: Text(



                                          "Daily Limit       :",

                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.blue[900]), 
                                        )),
                                    Container(

                                        padding: EdgeInsets.all(0),

                                        decoration: BoxDecoration(),
                                        child: Text(
                                          Globals.loggedInUser.dailyLimit.toString(), //print daily limit here
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.blue[900]),
                                        )),
                                  ],
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
                1.9,
                Container(
                  height: 160,
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
                        height: 20,
                      ),
                      FadeAnimation(
                          2,
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
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(),
                                        child: Text(
                                          "Total Savings   :",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.blue[900]),
                                        )),
                                    Container(
                                        padding: EdgeInsets.all(0),
                                        decoration: BoxDecoration(),
                                        child: Text(
                                          Globals.loggedInUser.savings.toString(), //print total savings here
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.blue[900]),
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  height: 50,
                                  width: double.infinity,
                                  margin: EdgeInsets.symmetric(horizontal: 50),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.blue[900]),
                                  child: FlatButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(30.0)),
                                    color: Colors.blue[900],
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Savings(),
                                          ));
                                    },
                                    child: Text(
                                      "Add Savings",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
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

//logout alert box
showAlertDialog(BuildContext context) {
  // Create button
  Widget okButton = FlatButton(
    child: Text("Yes"),
    onPressed: () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Login(),
          ));
    },
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    title: Text(
      "Logout",
      style: TextStyle(color: Colors.red),
    ),
    content: Text("Do you want to logout?"),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
