import 'package:pockett/animation/FadeAnimation.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class Savings extends StatefulWidget {
  @override
  _SavingsState createState() => _SavingsState();
}

class _SavingsState extends State<Savings> {
  TextEditingController noteController = TextEditingController();
  TextEditingController amountController = TextEditingController();
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
                        "Savings",
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  FadeAnimation(
                      1.3,
                      Text(
                        "Add your savings",
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
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 60,
                        ),
                        FadeAnimation(
                            1.4,
                            Column(
                              children: <Widget>[
                                TextField(
                                  controller: noteController,
                                  decoration: InputDecoration(
                                    labelText: "Saving for (eg: birthday)",
                                    icon: Icon(
                                      Icons.menu_book,
                                      color: Colors.blue[900],
                                    ),
                                    labelStyle:
                                        TextStyle(color: Colors.blue[900]),
                                    hintText: "Saving for",
                                    hintStyle:
                                        TextStyle(color: Colors.blue[400]),
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                TextField(
                                  keyboardType: TextInputType.number,
                                  controller: amountController,
                                  decoration: InputDecoration(
                                    icon: Icon(
                                      Icons.account_balance_wallet,
                                      color: Colors.blue[900],
                                    ),
                                    labelText: "Amount",
                                    labelStyle:
                                        TextStyle(color: Colors.blue[900]),
                                    hintText: "Amount",
                                    hintStyle:
                                        TextStyle(color: Colors.blue[400]),
                                  ),
                                ),
                              ],
                            )),
                        SizedBox(
                          height: 40,
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        FadeAnimation(
                          1.8,
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
                                Navigator.pop(context);
                                Toast.show(
                                  "Savings Added",
                                  context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.BOTTOM,
                                );
                              },
                              child: Text(
                                "Add Savings",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
