import 'package:flutter/material.dart';
import 'package:shopon/providers/products_cart.dart';

class OrderItem {
  final String id;
  final int price;
  final List<CartItem> products;
  final DateTime date;

  OrderItem(
      {required this.id,
      required this.price,
      required this.products,
      required this.date});
}

class ProductsOrder with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> cartProducts, int total) {
    _orders.insert(
        0,
        OrderItem(
            id: DateTime.now.toString(),
            price: total,
            products: cartProducts,
            date: DateTime
                .now())); // .insert adds items at the beginning of list so that more recent orders are added at the top. .add adds items at the end of list.
    notifyListeners();
  }
}
