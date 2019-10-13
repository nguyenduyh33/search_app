import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../models/result.dart';

class Results with ChangeNotifier {
  List<Result> _results = [];

  List<Result> get results {
    return [..._results];
  }

  Future<void> findItemsByKeywords(String keywords) async {
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
    url += "&paginationInput.entriesPerPage=10000";

    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      Map<String, dynamic> findItemsByKeywordsResponse =
          extractedData['findItemsByKeywordsResponse']?.first;
      Map<String, dynamic> searchResult =
          findItemsByKeywordsResponse['searchResult']?.first;
      List extractedItems = searchResult == null || searchResult['item'] == null
          ? []
          : searchResult['item'];

      final List<Result> loadedResults = [];
      extractedItems.forEach((result) {
        final id = result['itemId']?.first;
        final title = result['title']?.first;
        final imageUrl = result['galleryURL']?.first;
        final description = result['subtitle']?.first ?? '';
        final sellingStatus = result['sellingStatus'].first;
        final Map<String, dynamic> currentPrice =
            sellingStatus['currentPrice']?.first;
        final currency =
            currentPrice != null ? currentPrice['@currencyId'] : null;
        final price = currentPrice != null ? currentPrice['__value__'] : null;

        final timeLeft = sellingStatus['timeLeft']?.first;

        print(id);
        print(title);
        print(imageUrl);
        print(description);
        print(sellingStatus);
        print(currentPrice);
        print(timeLeft);
        result = Result(
          id: id,
          title: title,
          imageUrl: imageUrl,
          description: description,
          currency: currency,
          price: price,
        );
        loadedResults.add(result);
      });
      _results = loadedResults;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}
