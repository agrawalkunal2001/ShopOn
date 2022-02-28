import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopon/providers/product.dart';
import 'package:shopon/providers/products_cart.dart';
import 'package:shopon/screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageURL;

  // ProductItem(this.id, this.title, this.imageURL);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    final cart = Provider.of<ProductsCart>(context,
        listen:
            false /* We do not want to rebuild this widget when cart provider updates*/);
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
        leading: Consumer<Product>(
          // It is just like provider.of which is used to rebuild just a small widget
          builder: (ctx, product, child) => IconButton(
              icon: Icon(
                  product.isFavourite
                      ? Icons.favorite
                      : Icons.favorite_border_outlined,
                  color: Theme.of(context).accentColor),
              onPressed: () {
                product.toggleFavourite();
              }),
          child: Text(
              "Never changes!"), // It is the third argument in the builder method. It never changes.
        ),
        title: Text(
          product.title,
          textAlign: TextAlign.center,
        ),
        trailing: Consumer<ProductsCart>(
          builder: (ctx, cart, _) => IconButton(
              icon: Icon(
                  cart.itemInCart(product.id)
                      ? Icons.shopping_cart
                      : Icons.add_shopping_cart,
                  color: Theme.of(context).accentColor),
              onPressed: () {
                cart.addItem(product.id, product.title, product.price);
                ScaffoldMessenger.of(context)
                    .hideCurrentSnackBar(); // It hides the current snackbar before showing new snackbar immediately.
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Added item to cart!",
                    ),
                    duration: Duration(seconds: 3),
                    action: SnackBarAction(
                      label: "UNDO",
                      onPressed: () {},
                    ),
                  ),
                ); // Scaffold.of reaches out to the nearest widget controlling the page, which is the scaffold widget in product overview screen.
              }),
        ),
      ),
    );
  }
}
