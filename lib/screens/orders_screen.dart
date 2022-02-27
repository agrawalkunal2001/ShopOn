import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopon/providers/products_order.dart';
import 'package:shopon/widgets/app_drawer.dart';
import 'package:shopon/widgets/order_item.dart' as oi;

class OrdersScreen extends StatelessWidget {
  static const routeName = "/order-screen";

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<ProductsOrder>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Orders"),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemBuilder: (ctx, index) => oi.OrderItem(
          order: orderData.orders[index],
        ),
        itemCount: orderData.orders.length,
      ),
    );
  }
}
