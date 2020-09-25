import 'package:pockett/screens/dashboard.dart';
import 'package:pockett/screens/login.dart';
import 'package:pockett/screens/reports.dart';
import 'package:flutter/material.dart';
import 'package:pockett/screens/tabItem.dart';
import 'package:pockett/screens/addExpense.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

final tabs = ['Dashboard', 'Calendar', 'Reports', 'Logout'];

class HomePageState extends State<HomePage> {
  final List<Widget> screens = [HomePage(), Reports()];
  int selectedPosition = 0;
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = Dashboard();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.blue[900],
        splashColor: Colors.blueAccent,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddExpense(),
              ));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//bottom navigation bar
      bottomNavigationBar: _buildBottomTab(),
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
    );
  }

//bottom navigation tab
  _buildBottomTab() {
    return BottomAppBar(
      color: Colors.blue[900],
      shape: CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          TabItem(
            text: tabs[0],
            icon: Icons.dashboard,
            isSelected: selectedPosition == 0,
            onTap: () {
              setState(() {
                currentScreen = Dashboard();
                selectedPosition = 0;
              });
            },
          ),
          TabItem(
            text: tabs[1],
            icon: Icons.calendar_today,
            isSelected: selectedPosition == 1,
            onTap: () {
              setState(() {
                selectedPosition = 1;
              });
            },
          ),
          SizedBox(
            width: 48,
          ),
          TabItem(
            text: tabs[2],
            icon: Icons.receipt,
            isSelected: selectedPosition == 2,
            onTap: () {
              setState(() {
                currentScreen = Reports();
                selectedPosition = 2;
              });
            },
          ),
          TabItem(
            text: tabs[3],
            icon: Icons.power_settings_new,
            isSelected: selectedPosition == 3,
            onTap: () {
              setState(() {
                selectedPosition = 3;
              });
              showAlertDialog(context);
            },
          ),
        ],
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
      "Logout??",
      style: TextStyle(color: Colors.red),
    ),
    content: Text("Are you sure you want to logout?"),
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
