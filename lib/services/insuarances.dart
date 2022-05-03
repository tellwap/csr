import 'dart:convert';

import 'package:csr/models/api_response.dart';
import 'package:csr/models/insuarance.dart';
import 'package:csr/utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Insuarances with ChangeNotifier {
  var _items = [];

  List<Insuarance> get items {
    return [..._items];
  }

  Future<ApiResponse> getInsuarances(int carId) async {
    ApiResponse _apiResponse = ApiResponse();

    try {
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        // 'Authorization': 'Bearer $_token'
      };
      var uri = Uri.parse(insuaranceURL);
      if (carId != null) {
        uri = uri.replace(query: 'car_id=$carId');
      }

      final response = await http.get(uri, headers: headers);
      print(jsonDecode(response.body));
      if (response.statusCode == 200) {
        _apiResponse.data = jsonDecode(response.body)
            .map((insuarance) => Insuarance.fromJson(insuarance))
            .toList();
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

  Future<ApiResponse> createInsuarance(
      int carId, String name, String expireDate) async {
    ApiResponse _apiResponse = ApiResponse();

    try {
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        // 'Authorization': 'Bearer $_token'
      };
      final response = await http.post(Uri.parse(insuaranceURL + 'create'),
          headers: headers,
          body: jsonEncode({
            'car': carId.toString(),
            'name': name,
            'expire_date': '2022-05-01',
          }));

      print(jsonDecode(response.body));
      if (response.statusCode == 201) {
        _apiResponse.data = Insuarance.fromJson(jsonDecode(response.body));

        _apiResponse.data as Insuarance;

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
