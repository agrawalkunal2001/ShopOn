import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopon/providers/products_cart.dart';

class CartScreen extends StatelessWidget {
  static const routeName = "/cart-screen";

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<ProductsCart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: <Widget>[
          Card(
              margin: EdgeInsets.all(15),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Total",
                      style: TextStyle(fontSize: 20),
                    ),
                    Spacer(),
                    Chip(
                      label: Text("\u{20B9}${cart.totalPrice}",
                          style: TextStyle(
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .headline6
                                  ?.color)),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          "ORDER NOW",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 15),
                        ))
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
