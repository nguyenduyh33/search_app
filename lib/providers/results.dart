import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../models/result.dart';
import '../models/search_response.dart';

class Results with ChangeNotifier {
  List<Result> _results = [];

  List<Result> get results {
    return [..._results];
  }

  Result findById(String id) {
    return _results.firstWhere((result) => result.itemId == id);
  }

  Future<void> findItemsByKeywords(String keywords) async {
    if (keywords.isEmpty) {
      return _clear();
    }

    keywords = Uri.encodeComponent(keywords);

    // loading appId from secrets.json file that is ignored from source control. replace with your own appId.
    final appId = await rootBundle.loadStructuredData('secrets.json',
        (String jsonString) async {
      return json.decode(jsonString)['api_key'];
    });

    var url = 'https://svcs.sandbox.ebay.com/services/search/FindingService/v1';
    url += '?OPERATION-NAME=findItemsByKeywords';
    url += '&SECURITY-APPNAME=$appId';
    url += "&GLOBAL-ID=EBAY-US";
    url += "&RESPONSE-DATA-FORMAT=JSON";
    url += "&REST-PAYLOAD";
    url += "&keywords=$keywords";
    url += "&paginationInput.entriesPerPage=1000";

    try {
      final response = await http.get(url);
      final responseObject = SearchResponse.fromJson(json.decode(response.body));
      print(responseObject);
      print(responseObject.searchResult);
      print(responseObject.paginationOutput);
      _results = responseObject.searchResult.items;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  void _clear() {
    _results = [];
    notifyListeners();
  }
}
