import '../models/result.dart';

class SearchResponse {
  SearchResult searchResult;
  PaginationOutput paginationOutput;

  SearchResponse({this.searchResult, this.paginationOutput});

  SearchResponse.fromJson(Map<String, dynamic> json) {
    if (json['findItemsByKeywordsResponse']?.first != null) {
      Map<String, dynamic> findItemsByKeywordsResponse =
          json['findItemsByKeywordsResponse'].first;
      if (findItemsByKeywordsResponse['searchResult']?.first != null) {
        searchResult = SearchResult.fromJson(
            findItemsByKeywordsResponse['searchResult'].first);
      }
      if (findItemsByKeywordsResponse['paginationOutput']?.first != null) {
        paginationOutput = PaginationOutput.fromJson(
            findItemsByKeywordsResponse['paginationOutput'].first);
      }
    }
  }
}

class SearchResult {
  String count;
  List<Result> items;

  SearchResult({this.count, this.items});

  SearchResult.fromJson(Map<String, dynamic> json) {
    count = json['@count'];
    items = [];
    if (json.containsKey('item')) {
      json['item'].forEach((v) {
        items.add(Result.fromJson(v));
      });
    }
  }
}

class PaginationOutput {
  int pageNumber;
  int entriesPerPage;
  int totalPages;
  int totalEntries;

  PaginationOutput(
      {this.pageNumber,
      this.entriesPerPage,
      this.totalPages,
      this.totalEntries});

  PaginationOutput.fromJson(Map<String, dynamic> json) {
    pageNumber = int?.parse(json['pageNumber']?.first);
    entriesPerPage = int?.parse(json['entriesPerPage']?.first);
    totalPages = int?.parse(json['totalPages']?.first);
    totalEntries = int?.parse(json['totalEntries']?.first);
  }
}
