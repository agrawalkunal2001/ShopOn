import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopon/providers/products_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = "/product-detail";

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)?.settings.arguments as String;
    final loadedProduct = Provider.of<ProductsProvider>(context,
            listen:
                false /* We do not want to rebuild this widget after it has been created once becuase nothing much is changing here. Setting listen to true(default) would build this widget whenever provider class is updated*/)
        .findItemById(productId);

    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
    );
  }
}
