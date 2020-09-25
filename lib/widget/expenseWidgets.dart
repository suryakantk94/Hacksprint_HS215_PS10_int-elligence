import 'package:flutter/material.dart';
//import '../screens/User.dart';
import '../screens/database-manager.dart';

class ExpenseWidgets {
  static Future<bool> regularDialogue(context,
      {String title,
      String body,
      String noButText = "No",
      String yesButText = "Yes"}) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Material(
          type: MaterialType.transparency,
          elevation: 6,
          child: AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            title: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: Theme.of(context).accentColor,
              ),
            ),
            content: Text(body),
            actions: <Widget>[
              // FlatButton(
              //   child: Text(
              //     noButText,
              //     style: TextStyle(
              //       fontSize: 16.0,
              //       color: Theme.of(context).accentColor,
              //     ),
              //   ),
              //   onPressed: () {
              //     Navigator.of(context).pop(false);
              //   },
              // ),
              FlatButton(
                child: Text(
                  yesButText,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Theme.of(context).accentColor,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  static Future<bool> fieldDialogue(context,
      {String title, String body, String yesButText = "Save"}) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Material(
          type: MaterialType.transparency,
          elevation: 6,
          child: AlertDialog(
            content: new TextField(
                keyboardType: TextInputType.number,
                maxLines: 1,
                autofocus: true,
                style: TextStyle(fontSize: 50, color: Colors.blue[900]),
                decoration: InputDecoration(
                    hintText: "Amount",
                    hintStyle: TextStyle(color: Colors.lightBlueAccent[100]),
                    //labelText: "Enter Amount",
                    labelStyle: TextStyle(color: Colors.blue[400]),
                    border: InputBorder.none)),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            title: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: Theme.of(context).accentColor,
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  yesButText,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Theme.of(context).accentColor,
                  ),
                ),
                onPressed: () {
                  Future<dynamic> loginFuture =
                      DBManager.db.setMonthlyIncome(10000);
                  loginFuture
                      .then((data) => {Navigator.of(context).pop(true)})
                      .catchError((err) => {
                            // Areeba: TODO: Handle error
                            /*Toast.show(
                      "Account login failed",
                      context,
                      duration: Toast.LENGTH_LONG,
                      gravity: Toast.BOTTOM,
                    )*/
                          });

                  // Areeba: TODO: Remove this
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
