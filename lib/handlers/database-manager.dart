import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import '../entities/GlobalData.dart' as Globals;
import '../entities/User.dart';
import '../entities/Expense.dart';

class DBManager {
  DBManager._();

  String baseUrl = "https://pure-reaches-26058.herokuapp.com";
  String baseUsersUrl = "https://pure-reaches-26058.herokuapp.com/users";
  String baseExpensesUrl = "https://pure-reaches-26058.herokuapp.com/expenses";
  String baseLoginUrl = "https://pure-reaches-26058.herokuapp.com/login";

/*
  String baseUrl = "http://localhost:3000";
  String baseUsersUrl = "http://localhost:3000/users";
  String baseLoginUrl = "http://localhost:3000/auth";
*/
  static final DBManager db = DBManager._();

  dynamic _response(http.Response response) {
    print("==================Statuscode");
    print(response.statusCode);
    switch (response.statusCode) {
      case 200:
        return response.body.toString();
      case 204:
        return "";
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:

      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:

      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode :${response.statusCode}');
    }
  }

  Future getData() async {
    http.Response response = await http.get(baseUsersUrl);
    var data = jsonDecode(response.body);
    print(data.toString());
  }

  Future<dynamic> registerUser(User u) async {
    print("Registering user");

    var responseJson;
    try {
      final response = await http.post(baseUsersUrl,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            "username": u.username,
            "password": u.password,
            "phoneNumber": u.phoneNumber
          }));
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> addExpense(Expense e) async {
    print("Adding expense");
    String url = baseExpensesUrl;
    print(url);
    print(e.where);
    print(e.amount);
    print(e.date);
    String ds = e.date.toIso8601String();
    print(ds);
    var responseJson;
    try {
      final response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            "userId": Globals.loggedInUser.id,
            "where": e.where,
            "amount": e.amount,
            "date": ds
          }));
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future updateLoggedInUserCache() async {
    String url = baseUsersUrl + "/" + Globals.loggedInUser.id;
    print("Updating local cache");
    print(url);
    var responseJson;
    try {
      final response = await http.get(url);
      print("from updateLoggedInUserCache");
      print(response);
      responseJson = _response(response);
      var decoded;
      if (responseJson != "") {
        //Globals.loggedInUser = User.fromJson(jsonDecode(responseJson));
      }
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> loginUser(User u) async {
    print("Calling login user");
    var responseJson;
    try {
      final response = await http.post(baseLoginUrl,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            "username": u.username,
            "password": u.password
          }));

      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<void> setMonthlyIncome(double i) async {
    print("Calling set monthly income ");

    var responseJson;
    String url = baseUsersUrl + "/" + Globals.loggedInUser.id;
    try {
      final response = await http.put(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, double>{"monthlyIncome": i}));

      responseJson = _response(response);
      //updateLoggedInUserCache();
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<void> setDailyLimit(double i) async {
    print("Calling daily limit ");

    var responseJson;
    String url = baseUsersUrl + "/" + Globals.loggedInUser.id;
    try {
      final response = await http.put(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{"dailyLimit": i}));

      responseJson = _response(response);
      //updateLoggedInUserCache();
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<void> addSavings(double i) async {
    print("Calling add savings");

    var responseJson;
    String url = baseUsersUrl + "/" + Globals.loggedInUser.id;
    try {
      final response = await http.put(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, double>{"saving": i}));

      responseJson = _response(response);
      updateLoggedInUserCache();
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }
  addUsernameToSF(String s) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('Username', s);
  }

  addUserIdToSF(String s) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('UserId', s);
  }

  getUsernameSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String stringValue = prefs.getString("Username");
    return stringValue;
  }

  getUserIdSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String stringValue = prefs.getString("UserId");
    return stringValue;
  }

  removeValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Remove String
    prefs.remove("stringValue");
    //Remove bool
    prefs.remove("boolValue");
    //Remove int
    prefs.remove("intValue");
    //Remove double
    prefs.remove("doubleValue");
  }
}

class CustomException implements Exception {
  final _message;
  final _prefix;

  CustomException([this._message, this._prefix]);

  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends CustomException {
  FetchDataException([String message])
      : super(message, "Error During Communication: ");
}

class BadRequestException extends CustomException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends CustomException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}

class InvalidInputException extends CustomException {
  InvalidInputException([String message]) : super(message, "Invalid Input: ");
}
