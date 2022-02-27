import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopon/providers/products_cart.dart';
import 'package:shopon/screens/cart_screen.dart';
import 'package:shopon/widgets/app_drawer.dart';
import 'package:shopon/widgets/badge.dart';
import 'package:shopon/widgets/products_grid.dart';

enum FilterOptions { Favourites, All }

class ProductsOverviewScreen extends StatefulWidget {
  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showFavouritesOnly = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ShopOn"),
        actions: <Widget>[
          PopupMenuButton(
              onSelected: (FilterOptions selectedValue) {
                setState(() {
                  if (selectedValue == FilterOptions.Favourites) {
                    _showFavouritesOnly = true;
                  } else {
                    _showFavouritesOnly = false;
                  }
                });
              },
              itemBuilder: (_) => [
                    PopupMenuItem(
                        child: Text("Only Favourites"),
                        value: FilterOptions
                            .Favourites /* To define what would happen when it is clicked*/),
                    PopupMenuItem(
                        child: Text("Show All"), value: FilterOptions.All),
                  ],
              icon: Icon(Icons.more_vert)),
          Consumer<ProductsCart>(
            builder: (_, cartData, _2) => Badge(
                child: IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () {
                    Navigator.of(context).pushNamed(CartScreen.routeName);
                  },
                ),
                value: cartData.itemCount.toString(),
                color: Theme.of(context).accentColor),
          )
        ],
      ),
      drawer: AppDrawer(),
      body: ProductsGrid(_showFavouritesOnly),
    );
  }
}
