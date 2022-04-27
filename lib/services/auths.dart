import 'dart:async';
import 'dart:convert';
import 'package:csr/models/api_response.dart';
import 'package:csr/models/user.dart';
import 'package:csr/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String? _token;
  User? _user;

  DateTime _expireDate = DateTime.now();
  Timer? _autTimer;

  // String _userId;
  User? get user {
    return _user;
  }

  bool get isAuth {
    if (_token == null) {
      return false;
    }
    return true;
  }

  //
  // String get token{
  //   if(_token.isNotEmpty &&_expireDate != null && _expireDate.isAfter(DateTime.now())){
  //     return _token;
  //   }
  //   return null;
  // }
  String? get token {
    return _token;
  }

  Future<ApiResponse> login(String account, String password) async {
    ApiResponse _apiResponse = ApiResponse();
    try {
      final response = await http.post(Uri.parse(loginURL),
          body: {'account': account, 'password': password});

      print(response.body);

      switch (response.statusCode) {
        case 200:
          //assign local value
          _token = jsonDecode(response.body)['access'];
          _user = User.fromJson(jsonDecode(response.body)['user']);
          _expireDate = DateTime.now().add(const Duration(minutes: 30));
          _autoLogout();
          notifyListeners();

          //store local
          final pref = await SharedPreferences.getInstance();
          final userData = jsonEncode({
            'access': _token,
            'user': jsonDecode(response.body)['user'],
            'refresh': jsonDecode(response.body)['refresh'],
            'expireDate': _expireDate.toIso8601String()
          });
          pref.setString('userData', userData);

          break;
        case 401:
          _apiResponse.error = jsonDecode(response.body)['detail'];
          break;
        default:
          _apiResponse.error = somethingWentWrong;
      }
    } catch (e) {
      print(e);
      _apiResponse.error = e.toString();
    }
    return _apiResponse;
  }

  Future<void> logout() async {
    _token = null;
    _user = null;
    if (_autTimer != null) {
      _autTimer?.cancel();
      _autTimer = null;
    }
    final pref = await SharedPreferences.getInstance();
    pref.clear();
    notifyListeners();
  }

  void _autoLogout() async {
    if (_autTimer != null) {
      _autTimer?.cancel();
    }
    final timeToExpire = _expireDate.difference(DateTime.now()).inSeconds;
    _autTimer = Timer(Duration(seconds: timeToExpire), logout);
    // _autTimer = Timer(Duration(minutes: 50), logout);

    final prefs = await SharedPreferences.getInstance();
    // prefs.remove('userData');
    prefs.clear();
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    String userdata = prefs.getString('userData') as String;
    print(userdata);
    final extractedUserData = jsonDecode(userdata);
    final expireDate = DateTime.parse(extractedUserData['expireDate']);
    if (expireDate.isBefore(DateTime.now())) {
      return false;
    }
    _token = extractedUserData['access'];
    _user = User.fromJson(extractedUserData['user']);
    // _account = jsonDecode(prefs.getString('account') as String);

    _expireDate = expireDate;
    _autoLogout();
    notifyListeners();
    return true;
  }

  Future<ApiResponse> register(String firstName, String lastName, String email,
      String phoneNumber, String password) async {
    ApiResponse _apiResponse = ApiResponse();
    try {
      final response = await http.post(Uri.parse(registerURL), body: {
        'first_name': firstName,
        'last_name': lastName,
        'phone_number': phoneNumber,
        'email': email,
        'password': password,
      });

      switch (response.statusCode) {
        case 200:
          print('successf');
          _apiResponse.error = null;
          break;
        case 400:
          _apiResponse.error = jsonEncode(jsonDecode(response.body));
          break;
        case 401:
          _apiResponse.error = jsonDecode(response.body)['detail'];
          break;
        default:
          _apiResponse.error = somethingWentWrong;
      }
    } catch (e) {
      print(e);
      _apiResponse.error = e.toString();
    }
    return _apiResponse;
  }
}
