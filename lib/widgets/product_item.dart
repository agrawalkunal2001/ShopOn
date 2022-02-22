import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopon/providers/product.dart';
import 'package:shopon/screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageURL;

  // ProductItem(this.id, this.title, this.imageURL);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    return GridTile(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .pushNamed(ProductDetailScreen.routeName, arguments: product.id);
        },
        child: Image.network(
          product.imageURL,
          fit: BoxFit.cover,
        ),
      ),
      footer: GridTileBar(
        backgroundColor: Colors.black54,
        leading: IconButton(
            icon: Icon(
                product.isFavourite
                    ? Icons.favorite
                    : Icons.favorite_border_outlined,
                color: Theme.of(context).accentColor),
            onPressed: () {
              product.toggleFavourite();
            }),
        title: Text(
          product.title,
          textAlign: TextAlign.center,
        ),
        trailing: IconButton(
            icon:
                Icon(Icons.shopping_cart, color: Theme.of(context).accentColor),
            onPressed: () {}),
      ),
    );
  }
}
