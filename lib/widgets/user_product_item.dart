import 'package:flutter/material.dart';
import 'package:shopon/providers/products_provider.dart';
import 'package:shopon/screens/edit_product_screen.dart';
import 'package:provider/provider.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageURL;
  var isLoading = false;

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
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text("Are you sure?"),
                      content: Text("Do you want to delete this item?"),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(ctx).pop(false);
                          },
                          child: Text(
                            "NO",
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Provider.of<ProductsProvider>(context,
                                    listen: false)
                                .deleteProducts(id)
                                .then((value) => {
                                      Navigator.of(ctx).pop(true),
                                      ScaffoldMessenger.of(context)
                                          .hideCurrentSnackBar(), // It hides the current snackbar before showing new snackbar immediately.
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(
                                          "Product deleted!",
                                        ),
                                        duration: Duration(seconds: 3),
                                        action: SnackBarAction(
                                          label: "UNDO",
                                          onPressed: () {},
                                        ),
                                      )),
                                    });
                          },
                          child: Text(
                            "YES",
                            style: TextStyle(fontSize: 17),
                          ),
                        )
                      ],
                    ),
                  );
                },
                icon: Icon(Icons.delete, color: Theme.of(context).accentColor)),
          ],
        ),
      ),
    );
  }
}
