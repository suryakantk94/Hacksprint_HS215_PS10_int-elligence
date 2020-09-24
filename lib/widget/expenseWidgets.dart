import 'package:flutter/material.dart';

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
}
