import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final int price;

  CartItem(
      {required this.id,
      required this.title,
      required this.quantity,
      required this.price});
}

class ProductsCart with ChangeNotifier {
  Map<String, CartItem> _items = {};
  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  bool itemInCart(String itemId) {
    return _items.containsKey(itemId);
  }

  void addItem(String itemId, String itemTitle, int itemPrice) {
    if (_items.containsKey(itemId)) {
      _items.update(
          itemId,
          (value) => CartItem(
              id: value.id,
              title: value.title,
              quantity: value.quantity + 1,
              price: value.price));
    } else {
      _items.putIfAbsent(
          itemId,
          () => CartItem(
              id: itemId, title: itemTitle, quantity: 1, price: itemPrice));
    }
    notifyListeners();
  }
}
