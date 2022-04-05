import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopon/providers/products_order.dart';
import 'package:shopon/widgets/app_drawer.dart';
import 'package:shopon/widgets/loading_spinner.dart';
import 'package:shopon/widgets/order_item.dart' as oi;

class OrdersScreen extends StatefulWidget {
  static const routeName = "/order-screen";

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var isLoading = false;
  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) async {
      setState(() {
        isLoading = true;
      });
      await Provider.of<ProductsOrder>(context, listen: false)
          .fetchAndSetOrders();
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<ProductsOrder>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Orders"),
      ),
      drawer: AppDrawer(),
      body: isLoading
          ? LoadingSpinner()
          : ListView.builder(
              itemBuilder: (ctx, index) => oi.OrderItem(
                order: orderData.orders[index],
              ),
              itemCount: orderData.orders.length,
            ),
    );
  }
}
