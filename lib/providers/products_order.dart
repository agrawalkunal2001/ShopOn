import 'package:flutter/material.dart';
import 'package:shopon/providers/products_cart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

  final String token;
  final String userId;
  ProductsOrder(this.token, this.userId, this._orders);

  Future<void> fetchAndSetOrders() async {
    final url = Uri.parse(
        'https://shopon-dc94c-default-rtdb.firebaseio.com/orders/$userId.json?auth=$token');
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String,
        dynamic>; // When we decode the fetched data, we get a nested map. We get a map which contain string ids as keys and maps as values. These maps then contain the actual data like description and price.
    final List<OrderItem> loadedOrders = [];
    if (extractedData == null) {
      return;
    }
    extractedData.forEach((orderId /*key*/, orderData /*value*/) {
      loadedOrders.add(OrderItem(
          id: orderId,
          price: orderData["amount"],
          date: DateTime.parse(orderData["date"]),
          products: (orderData["products"] as List<dynamic>)
              .map((item) => CartItem(
                  id: item["id"],
                  title: item["title"],
                  quantity: item["quantity"],
                  price: item["price"]))
              .toList()));
    });
    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartProducts, int total) async {
    final url = Uri.parse(
        'https://shopon-dc94c-default-rtdb.firebaseio.com/orders/$userId.json?auth=$token');
    final timeStamp = DateTime
        .now(); // Creating this timestamp before http request to remove the delay between time recorded in local memory storage and database storage.
    final response = await http.post(url,
        body: json.encode({
          "amount": total,
          "date": timeStamp.toIso8601String(),
          "products": cartProducts
              .map((cp) => {
                    "id": cp.id,
                    "title": cp.title,
                    "quantity": cp.quantity,
                    "price": cp.price,
                  })
              .toList(), // Converting objects to maps.
        }));
    _orders.insert(
        0,
        OrderItem(
            id: json.decode(response.body)["name"],
            price: total,
            products: cartProducts,
            date:
                timeStamp)); // .insert adds items at the beginning of list so that more recent orders are added at the top. .add adds items at the end of list.
    notifyListeners();
  }
}
