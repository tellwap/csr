import 'dart:convert';

import 'package:csr/models/api_response.dart';
import 'package:csr/models/car.dart';
import 'package:csr/utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Cars with ChangeNotifier {
  var _items = [];

  List<Car> get items {
    return [..._items];
  }

  Future<ApiResponse> getCars() async {
    ApiResponse _apiResponse = ApiResponse();

    try {
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        // 'Authorization': 'Bearer $_token'
      };
      final response =
          await http.get(Uri.parse(insuaranceURL + 'cars'), headers: headers);
      print(jsonDecode(response.body));
      if (response.statusCode == 200) {
        _apiResponse.data =
            jsonDecode(response.body).map((car) => Car.fromJson(car)).toList();
        _apiResponse.data as List<dynamic>;

        //update provider items
        _items = _apiResponse.data as List<dynamic>;
        notifyListeners();
      } else {
        _apiResponse.error = somethingWentWrong;
      }
    } catch (error) {
      print(error);
      _apiResponse.error = serverError;
    }
    return _apiResponse;
  }

  Future<ApiResponse> createCar(String name, String plateNo) async {
    ApiResponse _apiResponse = ApiResponse();

    try {
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        // 'Authorization': 'Bearer $_token'
      };
      final response = await http.post(Uri.parse(insuaranceURL + 'cars/create'),
          headers: headers,
          body: jsonEncode({'name': name, 'plate_no': plateNo}));
      print(jsonDecode(response.body));
      if (response.statusCode == 201) {
        _apiResponse.data = Car.fromJson(jsonDecode(response.body));

        _apiResponse.data as Car;

        //update provider items
        _items.insert(0, _apiResponse.data);
        notifyListeners();
      } else {
        _apiResponse.error = somethingWentWrong;
      }
    } catch (error) {
      print(error);
      _apiResponse.error = serverError;
    }
    return _apiResponse;
  }
}
