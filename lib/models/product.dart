import 'package:flutter/material.dart';

class Product {
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
}
