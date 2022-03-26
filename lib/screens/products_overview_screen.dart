import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopon/providers/products_cart.dart';
import 'package:shopon/providers/products_provider.dart';
import 'package:shopon/screens/cart_screen.dart';
import 'package:shopon/widgets/app_drawer.dart';
import 'package:shopon/widgets/badge.dart';
import 'package:shopon/widgets/loading_spinner.dart';
import 'package:shopon/widgets/products_grid.dart';

enum FilterOptions { Favourites, All }

class ProductsOverviewScreen extends StatefulWidget {
  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showFavouritesOnly = false;
  var _isInit = true;
  var isLoading = false;

  @override
  void initState() {
    // This will run first when the screen loads and will run only once.
    // Provider.of<ProductsProvider>(context).fetchAndSetProducts(); // This will not work as .of(context) is not fully wired up here. It can work if we set listen: false.

    // Future.delayed(Duration.zero).then((value) =>
    //     {Provider.of<ProductsProvider>(context).fetchAndSetProducts()}); // This would work technically as the duration is set to zero but first the class will be initialised and then this will run.

    super.initState();
  }

  @override
  void didChangeDependencies() {
    // This will run after the widget tree has been initialised but before the build method runs for the first time. It runs multiple times.
    if (_isInit) {
      setState(() {
        isLoading = true;
      });
      Provider.of<ProductsProvider>(context).fetchAndSetProducts().then((_) {
        setState(() {
          isLoading = false;
        });
      });
    }

    _isInit = false;
    super.didChangeDependencies();
  }

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
      body: isLoading ? LoadingSpinner() : ProductsGrid(_showFavouritesOnly),
    );
  }
}
