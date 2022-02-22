import 'package:flutter/material.dart';

import 'package:shopon/widgets/products_grid.dart';

class ProductsOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ShopOn"),
      ),
      body: ProductsGrid(),
    );
  }
}
