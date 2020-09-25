import 'package:pockett/animation/FadeAnimation.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class AddExpense extends StatefulWidget {
  @override
  _AddExpenseState createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  TextEditingController noteController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  int dueDateTimestamp;
  final dateFormat = DateFormat('dd-MM-yyyy');
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
                        "Add Expenses",
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  FadeAnimation(
                      1.3,
                      Text(
                        "Add your spends",
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
                            1.5,
                            Column(
                              children: <Widget>[
                                TextField(
                                  controller: noteController,
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.blue[900]),
                                  decoration: InputDecoration(
                                    labelText:
                                        "Where did you spent?(eg: Coffee)",
                                    labelStyle:
                                        TextStyle(color: Colors.blue[900]),
                                    hintText: "Spent on",
                                    hintStyle:
                                        TextStyle(color: Colors.blue[400]),
                                    // icon: Icon(Icons.library_books_sharp,
                                    //     color: Colors.blue[900]),
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                TextField(
                                  keyboardType: TextInputType.number,
                                  controller: amountController,
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.blue[900]),
                                  decoration: InputDecoration(
                                    labelText: "Amount",
                                    labelStyle:
                                        TextStyle(color: Colors.blue[900]),
                                    hintText: "Amount",
                                    hintStyle:
                                        TextStyle(color: Colors.blue[400]),
                                    icon: Icon(Icons.account_balance_wallet,
                                        color: Colors.blue[900]),
                                  ),
                                ),
                              ],
                            )),
                        SizedBox(
                          height: 40,
                        ),
                        FadeAnimation(
                          1.7,
                          DateTimeField(
                            style: TextStyle(
                                fontSize: 20, color: Colors.blue[500]),
                            controller: dateController,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                                borderSide: BorderSide(
                                    width: 1, color: Colors.blueAccent),
                              ),
                              //errorText: bdErr ? "Please Choose Birth Date" : null,
                              labelText: 'Select Date',
                              labelStyle: TextStyle(color: Colors.blue[900]),
                            ),
                            format: dateFormat,
                            onShowPicker: (context, currentValue) {
                              return DatePicker.showDatePicker(
                                context,
                                showTitleActions: true,
                                theme: DatePickerTheme(
                                  itemStyle: TextStyle(
                                    color: Colors.blue[900],
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                  doneStyle: TextStyle(
                                    color: Colors.blue[900],
                                    fontSize: 16,
                                  ),
                                ),
                              );
                            },
                            onChanged: (value) {},
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        FadeAnimation(
                          1.9,
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
                                  "Expense Added",
                                  context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.BOTTOM,
                                );
                              },
                              child: Text(
                                "Add Expense",
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
