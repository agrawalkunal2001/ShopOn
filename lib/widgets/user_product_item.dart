import 'package:flutter/material.dart';
import 'package:shopon/providers/products_provider.dart';
import 'package:shopon/screens/edit_product_screen.dart';
import 'package:provider/provider.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageURL;

  UserProductItem(
      {required this.id, required this.title, required this.imageURL});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageURL),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(EditProductScreen.routeName, arguments: id);
                },
                icon: Icon(Icons.edit, color: Theme.of(context).primaryColor)),
            IconButton(
                onPressed: () {
                  Provider.of<ProductsProvider>(context, listen: false)
                      .deleteProducts(id);
                },
                icon: Icon(Icons.delete, color: Theme.of(context).accentColor)),
          ],
        ),
      ),
    );
  }
}
