import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageURL;

  ProductItem(this.id, this.title, this.imageURL);

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Image.network(
        imageURL,
        fit: BoxFit.cover,
      ),
      footer: GridTileBar(
        backgroundColor: Colors.black54,
        leading: IconButton(
            icon: Icon(Icons.favorite, color: Theme.of(context).accentColor),
            onPressed: () {}),
        title: Text(
          title,
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