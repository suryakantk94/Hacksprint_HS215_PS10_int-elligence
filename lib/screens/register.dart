import 'package:pockett/animation/FadeAnimation.dart';
import 'package:flutter/material.dart';
import 'package:pockett/widget/ExpenseWidgets.dart';
import 'package:pockett/screens/login.dart';
import 'package:toast/toast.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController conpassController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
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
                        "Register",
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  FadeAnimation(
                      1.3,
                      Text(
                        "Create new account",
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
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey[200]))),
                                    child: TextField(
                                      controller: nameController,
                                      decoration: InputDecoration(
                                          hintText: "Username",
                                          hintStyle: TextStyle(
                                              color:
                                                  Colors.lightBlueAccent[100]),
                                          labelText: "Username",
                                          labelStyle: TextStyle(
                                              color: Colors.blue[400]),
                                          border: InputBorder.none),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey[200]))),
                                    child: TextField(
                                      controller: passController,
                                      decoration: InputDecoration(
                                          hintText: "Password",
                                          hintStyle: TextStyle(
                                              color:
                                                  Colors.lightBlueAccent[100]),
                                          labelText: "Password",
                                          labelStyle: TextStyle(
                                              color: Colors.blue[400]),
                                          border: InputBorder.none),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey[200]))),
                                    child: TextField(
                                      controller: conpassController,
                                      decoration: InputDecoration(
                                          hintText: "Confirm Password",
                                          hintStyle: TextStyle(
                                              color:
                                                  Colors.lightBlueAccent[100]),
                                          labelText: "Confirm Password",
                                          labelStyle: TextStyle(
                                              color: Colors.blue[400]),
                                          border: InputBorder.none),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey[200]))),
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      controller: phoneController,
                                      decoration: InputDecoration(
                                          hintText: "Phone Number",
                                          hintStyle: TextStyle(
                                              color:
                                                  Colors.lightBlueAccent[100]),
                                          labelText: "Phone Number",
                                          labelStyle: TextStyle(
                                              color: Colors.blue[400]),
                                          border: InputBorder.none),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                        SizedBox(
                          height: 40,
                        ),
                        FadeAnimation(
                          1.6,
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
                                if (nameController.text == "" ||
                                    passController.text == "" ||
                                    conpassController.text == "" ||
                                    phoneController.text == "") {
                                  ExpenseWidgets.regularDialogue(context,
                                      title: "Failed",
                                      body: "Please fill all the fields!!",
                                      yesButText: "Ok");
                                } else {
                                  if (passController.text !=
                                      conpassController.text) {
                                    ExpenseWidgets.regularDialogue(context,
                                        title: "Failed",
                                        body: "Passwords doesn't Match!!",
                                        yesButText: "Ok");
                                  } else {
                                    // ExpenseWidgets.regularDialogue(context,
                                    //     title: "Successful",
                                    //     body: "Registration Successful!!",
                                    //     yesButText: "Ok");
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Login(),
                                        ));
                                    Toast.show(
                                      "Account Registered Successfully",
                                      context,
                                      duration: Toast.LENGTH_LONG,
                                      gravity: Toast.BOTTOM,
                                    );
                                  }
                                }
                                // nameController.text = "";
                                passController.text = "";
                                conpassController.text = "";
                                // phoneController.text = "";
                              },
                              child: Text(
                                "Register",
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
