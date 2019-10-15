import 'package:intl/intl.dart';

class Result {
  String itemId = '';
  String title;
  String globalId;
  String subtitle;
  PrimaryCategory primaryCategory;
  String category;
  String galleryURL;
  String postalCode;
  String location;
  String country;
  SellingStatus sellingStatus;
  String returnsAccepted;
  Condition condition;
  String imageUrl = 'https://picsum.photos/500';

  get duration {
    Duration calculatedDuration = Duration();
    if (sellingStatus?.timeLeft != null) {
      String days = RegExp(r'\d*(?=D)').stringMatch(sellingStatus?.timeLeft);
      String hours = RegExp(r'\d*(?=H)').stringMatch(sellingStatus?.timeLeft);
      String minutes = RegExp(r'\d*(?=M)').stringMatch(sellingStatus?.timeLeft);
      String seconds = RegExp(r'\d*(?=S)').stringMatch(sellingStatus?.timeLeft);
      calculatedDuration = Duration(
        days: int.parse(days),
        hours: int.parse(hours),
        minutes: int.parse(minutes),
        seconds: int.parse(seconds),
      );
    }
    return calculatedDuration;
  }

  get isExpiringWithin24Hours => duration.inDays <= 1;

  get price => NumberFormat("#,##0.00", "en_US")
      .format(double.parse(sellingStatus.currentPrice.value));

  get timeLeftSummary {
    String timeLeftValue = 'unknown';
    if (duration == null) {
      return timeLeftValue;
    }
    if (duration.inDays > 0) {
      return '${this.duration.inDays}d';
    }
    if (duration.inHours > 0) {
      return '${this.duration.inHours}h';
    }
    if (duration.inMinutes > 0) {
      return '${this.duration.inMinutes}m';
    }
    if (duration.inSeconds > 0) {
      return '${this.duration.inMinutes}s';
    }
    return timeLeftValue;
  }

  Result({
    this.itemId,
    this.title,
    this.globalId,
    this.subtitle,
    this.category,
    this.galleryURL,
    this.postalCode,
    this.location,
    this.country,
    this.sellingStatus,
    this.returnsAccepted,
    this.condition,
  });

  Result.fromJson(Map<String, dynamic> json) {
    itemId = json['itemId']?.first;
    title = json['title']?.first;
    globalId = json['globalId']?.first;
    subtitle = json['subtitle']?.first;
    if (json['primaryCategory']?.first != null) {
      primaryCategory = PrimaryCategory.fromJson(json['primaryCategory'].first);
    }
    galleryURL = json['galleryURL']?.first;
    postalCode = json['postalCode']?.first;
    location = json['location']?.first;
    country = json['country']?.first;
    if (json['sellingStatus']?.first != null) {
      sellingStatus = SellingStatus.fromJson(json['sellingStatus'].first);
    }
    returnsAccepted = json['returnsAccepted']?.first;
    if (json['condition']?.first != null) {
      condition = Condition.fromJson(json['condition'].first);
    }
  }
}

class PrimaryCategory {
  String categoryName;

  PrimaryCategory({this.categoryName});

  PrimaryCategory.fromJson(Map<String, dynamic> json) {
    categoryName = json['categoryName']?.first;
  }
}

class SellingStatus {
  CurrentPrice currentPrice;
  String timeLeft;

  SellingStatus({this.currentPrice, this.timeLeft});

  SellingStatus.fromJson(Map<String, dynamic> json) {
    currentPrice = CurrentPrice.fromJson(json['currentPrice']?.first);
    timeLeft = json['timeLeft']?.first;
  }
}

class CurrentPrice {
  String currencyId;
  String value;

  CurrentPrice({this.currencyId, this.value});

  CurrentPrice.fromJson(Map<String, dynamic> json) {
    currencyId = json['@currencyId'];
    value = json['__value__'];
  }
}

class Condition {
  String conditionDisplayName;

  Condition({this.conditionDisplayName});

  Condition.fromJson(Map<String, dynamic> json) {
    conditionDisplayName = json['conditionDisplayName']?.first as String;
  }
}
