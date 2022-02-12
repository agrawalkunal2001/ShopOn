import 'package:flutter/material.dart';
import 'package:shopon/models/product.dart';

class ProductsProvider with /* Mixins or inheritance lite*/ ChangeNotifier {
  List<Product> _items = [];

  List<Product> get items {
    return [..._items];
  } // Adding getter method as _items is a private property which cannot be accessed from outised this class

}
