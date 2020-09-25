import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:toast/toast.dart';
import 'package:pockett/animation/FadeAnimation.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  CalendarController _controller;
  Map<DateTime, List<dynamic>> _events;
  List<dynamic> _selectedEvents;
  TextEditingController _eventController;
  //SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
    _eventController = TextEditingController();
    _events = {};
    _selectedEvents = [];
    // initPrefs();
  }

  Map<String, dynamic> encodeMap(Map<DateTime, dynamic> map) {
    Map<String, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[key.toString()] = map[key];
    });
    return newMap;
  }

  Map<DateTime, dynamic> decodeMap(Map<String, dynamic> map) {
    Map<DateTime, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[DateTime.parse(key)] = map[key];
    });
    return newMap;
  }

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
                        "Calendar",
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  FadeAnimation(
                      1.3,
                      Text(
                        "You can add new expenses from here.",
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
                          height: 20,
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
                                  TableCalendar(
                                    events: _events,
                                    availableCalendarFormats: const {
                                      CalendarFormat.week: 'Week',
                                      CalendarFormat.month: 'Month'
                                    },
                                    initialCalendarFormat: CalendarFormat.month,
                                    calendarStyle: CalendarStyle(
                                        canEventMarkersOverflow: true,
                                        todayColor: Colors.blue[900],
                                        selectedColor: Colors.blue[900],
                                        todayStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18.0,
                                            color: Colors.white)),
                                    headerStyle: HeaderStyle(
                                      centerHeaderTitle: true,
                                      formatButtonDecoration: BoxDecoration(
                                        color: Colors.blue[900],
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      formatButtonTextStyle:
                                          TextStyle(color: Colors.white),
                                      formatButtonShowsNext: false,
                                    ),
                                    startingDayOfWeek: StartingDayOfWeek.monday,
                                    onDaySelected: (date, events) {
                                      setState(() {
                                        _selectedEvents = events;
                                      });
                                    },
                                    builders: CalendarBuilders(
                                      selectedDayBuilder:
                                          (context, date, events) => Container(
                                              margin: const EdgeInsets.all(4.0),
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color: Colors.blue[900],
                                                shape: BoxShape.circle,
                                                //borderRadius: BorderRadius.circular(10.0)
                                              ),
                                              child: Text(
                                                date.day.toString(),
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )),
                                      todayDayBuilder:
                                          (context, date, events) => Container(
                                              margin: const EdgeInsets.all(4.0),
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color: Colors.lightBlue,
                                                shape: BoxShape.circle,
                                                //borderRadius: BorderRadius.circular(10.0)
                                              ),
                                              child: Text(
                                                date.day.toString(),
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )),
                                    ),
                                    calendarController: _controller,
                                  ),
                                  ..._selectedEvents.map(
                                    (event) => Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(width: 0.8),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 8.0, vertical: 4.0),
                                        child: ListTile(
                                          leading: Icon(
                                            Icons.account_balance_wallet,
                                            color: Colors.blue[900],
                                          ),
                                          title: Text(
                                            event,
                                            style: TextStyle(fontSize: 25),
                                          ),
                                        )),
                                  )
                                ],
                              ),
                            )),
                        SizedBox(
                          height: 30,
                        ),
                        FadeAnimation(
                          1.8,
                          Container(
                            height: 50,
                            width: double.infinity,
                            margin: EdgeInsets.symmetric(horizontal: 50),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.blue[500]),
                            child: FlatButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(30.0)),
                              color: Colors.blue[500],
                              onPressed: () {
                                _showAddDialog();
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

  _showAddDialog() async {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("New Expense"),
              content: TextField(
                keyboardType: TextInputType.number,
                controller: _eventController,
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text("Add", style: TextStyle(color: Colors.blue[900])),
                  onPressed: () {
                    if (_eventController.text.isEmpty) return;
                    if (_events[_controller.selectedDay] != null) {
                      _events[_controller.selectedDay]
                          .add(_eventController.text);
                    } else {
                      _events[_controller.selectedDay] = [
                        _eventController.text
                      ];
                    }
                    // prefs.setString("events", json.encode(encodeMap(_events)));
                    _eventController.clear();
                    Navigator.pop(context);
                    Toast.show(
                      "Expense Added",
                      context,
                      duration: Toast.LENGTH_LONG,
                      gravity: Toast.BOTTOM,
                    );
                  },
                )
              ],
            ));
    setState(() {
      _selectedEvents = _events[_controller.selectedDay];
    });
  }
}
