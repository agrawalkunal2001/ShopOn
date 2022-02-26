import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopon/providers/products_cart.dart';

class CartItem extends StatelessWidget {
  final String id; // Cart item id
  final String productId; // Product id
  final String title;
  final int price;
  final int quantity;

  CartItem(
      {required this.id,
      required this.productId,
      required this.title,
      required this.price,
      required this.quantity});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).accentColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      ),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        Provider.of<ProductsCart>(context, listen: false).removeItem(productId);
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: Text("\u{20B9}${price}"),
            ),
            title: Text(
              title,
              style: TextStyle(fontSize: 20),
            ),
            subtitle: Text("Total: \u{20B9}${price * quantity}",
                style: TextStyle(fontSize: 16)),
            trailing: Consumer<ProductsCart>(
              builder: (_, cart, _3) => Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      cart.decreaseQuantity(id);
                    },
                    icon: Icon(Icons.remove),
                  ),
                  Text(
                    "${quantity} X",
                    style: TextStyle(fontSize: 20),
                  ),
                  IconButton(
                    alignment: Alignment.centerRight,
                    onPressed: () {
                      cart.increaseQuantity(id);
                    },
                    icon: Icon(Icons.add),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
