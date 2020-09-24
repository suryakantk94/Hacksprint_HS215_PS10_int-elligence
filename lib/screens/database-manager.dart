import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'dart:async';

import 'User.dart';

class DBManager {
  DBManager._();

  String baseUrl = "https://obscure-springs-93376.herokuapp.com";
  String baseUsersUrl = "https://obscure-springs-93376.herokuapp.com/users";
  String baseLoginUrl = "https://obscure-springs-93376.herokuapp.com/login";
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
      final response = await http.post(
          baseUsersUrl,
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
      final response = await http.post(
          baseLoginUrl,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(
              <String, String>{"username": u.username, "password": u.password}));

      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
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
