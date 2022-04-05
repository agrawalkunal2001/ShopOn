import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final int price;
  final String imageURL;
  bool isFavourite;

  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.imageURL,
      this.isFavourite = false});

  Future<void> toggleFavourite() {
    isFavourite = !isFavourite;
    notifyListeners();
    final url = Uri.parse(
        'https://shopon-dc94c-default-rtdb.firebaseio.com/products/$id.json');
    return http.patch(url,
        body: json.encode({
          "isFavourite": isFavourite,
        }));
  }
}
