import 'package:flutter/foundation.dart';

class Result {
  final String id;
  final String title;
  final String description;
  final String condition;
  final String price;
  final String imageUrl;
  final DateTime date;
  final String currency;

  const Result({
    @required this.id,
    @required this.title,
    this.description = '',
    this.condition = '',
    this.price = '',
    this.imageUrl = '',
    this.date,
    this.currency = ''
  });
}
