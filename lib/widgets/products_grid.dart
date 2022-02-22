import 'package:flutter/material.dart';
import 'package:shopon/providers/products_provider.dart';
import 'package:shopon/widgets/product_item.dart';
import 'package:provider/provider.dart';

class ProductsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductsProvider>(
        context); // .of is a generic method. We can specify the type of data we want to listen to. This establishes a direct communication channel to the instance created of the provider class. Now, the provider package looks at the parent of products grid which is product overview screen and has no provider. Now, it goes to its parent which is my app and finds an instance of provider class.
    final productData = products.items;
    return GridView.builder(
      itemCount: productData.length,
      itemBuilder: (ctx, index) => ProductItem(
          productData[index].id,
          productData[index].title,
          productData[index]
              .imageURL), // It defines how the grid should look like.
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
      // It defines how the grid should be structured.
    );
  }
}
