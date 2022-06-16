import 'dart:convert';

import 'package:csr/models/alert.dart';
import 'package:csr/models/api_response.dart';
import 'package:csr/models/insuarance.dart';
import 'package:csr/utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Alerts with ChangeNotifier {
  var _items = [];

  List<Alert> get items {
    return [..._items];
  }

  Future<ApiResponse> getAlerts() async {
    ApiResponse _apiResponse = ApiResponse();

    try {
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        // 'Authorization': 'Bearer $_token'
      };
      var uri = Uri.parse(alertURL);

      final response = await http.get(uri, headers: headers);

      print(jsonDecode(response.body));

      if (response.statusCode == 200) {
        _apiResponse.data = jsonDecode(response.body)
            .map((alert) => Alert.fromJson(alert))
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
}
