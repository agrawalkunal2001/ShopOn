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

  int get totalPrice {
    int total = 0;
    _items.forEach((key, item) {
      total += item.price * item.quantity;
    });
    return total;
  }

  void increaseQuantity(String id) {
    _items.update(
        id,
        (value) => CartItem(
            id: value.id,
            title: value.title,
            quantity: value.quantity + 1,
            price: value.price));
    notifyListeners();
  }

  void decreaseQuantity(String id) {
    _items.update(
        id,
        (value) => CartItem(
            id: value.id,
            title: value.title,
            quantity:
                (value.quantity - 1) >= 1 ? value.quantity - 1 : value.quantity,
            price: value.price));
    notifyListeners();
  }

  void removeItem(String id) {
    _items.remove(id);
    notifyListeners();
  }

  void addItem(String itemId, String itemTitle, int itemPrice) {
    _items.putIfAbsent(
        itemId,
        () => CartItem(
            id: itemId, title: itemTitle, quantity: 1, price: itemPrice));

    notifyListeners();
  }
}
