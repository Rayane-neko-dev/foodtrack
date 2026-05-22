import 'dart:convert';

class FoodItem {
  final String id;
  final String name;
  final String category;
  final String location;
  final DateTime expiryDate;
  final DateTime purchaseDate;
  int quantity;
  String? imageUrl;

  FoodItem({
    required this.id,
    required this.name,
    required this.category,
    required this.location,
    required this.expiryDate,
    required this.purchaseDate,
    required this.quantity,
    this.imageUrl,
  });

  int get daysUntilExpiry {
    final now = DateTime.now();
    return expiryDate.difference(DateTime(now.year, now.month, now.day)).inDays;
  }

  String get expiryLabel {
    final days = daysUntilExpiry;
    if (days < 0) return 'Expired';
    if (days == 0) return 'Today';
    if (days == 1) return '1 day';
    if (days < 7) return '$days days';
    if (days < 14) return '1 week';
    if (days < 21) return '2 weeks';
    if (days < 28) return '3 weeks';
    return '${(days / 30).floor()} month${(days / 30).floor() > 1 ? "s" : ""}';
  }

  ExpiryStatus get status {
    final days = daysUntilExpiry;
    if (days < 0) return ExpiryStatus.expired;
    if (days <= 3) return ExpiryStatus.expiringSoon;
    if (days <= 7) return ExpiryStatus.nextWeek;
    return ExpiryStatus.goodForNow;
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'category': category,
        'location': location,
        'expiryDate': expiryDate.toIso8601String(),
        'purchaseDate': purchaseDate.toIso8601String(),
        'quantity': quantity,
        'imageUrl': imageUrl,
      };

  factory FoodItem.fromJson(Map<String, dynamic> json) => FoodItem(
        id: json['id'],
        name: json['name'],
        category: json['category'],
        location: json['location'],
        expiryDate: DateTime.parse(json['expiryDate']),
        purchaseDate: DateTime.parse(json['purchaseDate']),
        quantity: json['quantity'],
        imageUrl: json['imageUrl'],
      );

  static String encodeList(List<FoodItem> items) =>
      json.encode(items.map((e) => e.toJson()).toList());

  static List<FoodItem> decodeList(String encoded) =>
      (json.decode(encoded) as List)
          .map((e) => FoodItem.fromJson(e))
          .toList();
}

enum ExpiryStatus { expired, expiringSoon, nextWeek, goodForNow }