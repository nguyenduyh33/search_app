import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../models/result.dart';
import '../models/search_response.dart';

class Results with ChangeNotifier {
  static const int resultThreshold = 100;
  String _currentSearchTerm;
  int _currentPage = 1;
  int _totalPages = 0;

  List<Result> _results = [];

  List<Result> get results {
    return [..._results];
  }

  Result findById(String id) {
    return _results.firstWhere((result) => result.itemId == id);
  }

  Future<void> executeNewSearch(String keywords) async {
    _currentSearchTerm = keywords;
    _currentPage = 1;
    if (keywords.isEmpty) {
      return _clearResults();
    }
    return _findItemsByKeywords(keywords: keywords);
  }

  void handleResultBuilt(int index) {
    final resultPosition = index + 1;
    final requestMoreData =
        resultPosition % (resultThreshold * _currentPage) == 0;
    final pageToRequest = _currentPage + 1;

    if (requestMoreData && pageToRequest <= _totalPages) {
      _currentPage = pageToRequest;
      _paginateCurrentSearch();
    }
  }

  Future<void> _paginateCurrentSearch() {
    return _findItemsByKeywords(
        keywords: _currentSearchTerm, appendResults: true);
  }

  Future<void> _findItemsByKeywords(
      {@required String keywords, appendResults = false}) async {
    // Loading appId from secrets.json file that is ignored from source control. Replace with your own appId from the eBay developer site.
    final appId = await rootBundle.loadStructuredData('secrets.json',
        (String jsonString) async {
      return json.decode(jsonString)['api_key'];
    });

    final encodedKeywords = Uri.encodeComponent(keywords);
    final pageNumber = _currentPage.toString();
    final entriesPerPage = resultThreshold.toString();

    var url = 'https://svcs.sandbox.ebay.com/services/search/FindingService/v1';
    url += '?OPERATION-NAME=findItemsByKeywords';
    url += '&SECURITY-APPNAME=$appId';
    url += "&GLOBAL-ID=EBAY-US";
    url += "&RESPONSE-DATA-FORMAT=JSON";
    url += "&REST-PAYLOAD";
    url += "&keywords=$encodedKeywords";
    url += "&paginationInput.entriesPerPage=$entriesPerPage";
    url += "&paginationInput.pageNumber=$pageNumber";

    try {
      final response = await http.get(url);
      final responseObject =
          SearchResponse.fromJson(json.decode(response.body));
      _currentPage = responseObject.paginationOutput.pageNumber;
      _totalPages = responseObject.paginationOutput.totalPages;
      _results = appendResults
          ? [..._results, ...responseObject.searchResult.items]
          : [...responseObject.searchResult.items];
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  void _clearResults() {
    _results = [];
    notifyListeners();
  }
}
