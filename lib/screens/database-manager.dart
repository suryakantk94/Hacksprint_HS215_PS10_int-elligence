import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/globaldata.dart' as Globals;
import 'User.dart';

class DBManager {
  DBManager._();

  String baseUrl = "https://pure-reaches-26058.herokuapp.com";
  String baseUsersUrl = "https://pure-reaches-26058.herokuapp.com/users";
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

  Future<dynamic> setMonthlyIncome(double i) async {
    print("Calling set monthly income ");

    var responseJson;
    // String url = baseUsersUrl + "/" + Globals.loggedInUser.id;
    //print(url);
    try {
      final response = await http.put(
          "https://pure-reaches-26058.herokuapp.com/users/5f6d8043295b9a23cc293527",
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{"monthlyIncome": i}));

      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;

  }


  Future<dynamic> setDailyLimit(double i) async {
    print("Calling daily limit ");

    var responseJson;
    // String url = baseUsersUrl + "/" + Globals.loggedInUser.id;
    //print(url);
    try {
      final response = await http.put(
          "https://pure-reaches-26058.herokuapp.com/users/5f6d8043295b9a23cc293527",
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{"dailyLimit": i}));

      responseJson = _response(response);
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
