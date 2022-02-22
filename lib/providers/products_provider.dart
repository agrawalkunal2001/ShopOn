import 'package:flutter/material.dart';
import 'package:shopon/models/product.dart';

class ProductsProvider
    with /* Mixins or inheritance lite. It is like extending from a class. The difference is that we simply merge some properties or methods into existing class but does not return an instance of the inherited class.*/ ChangeNotifier /* It is related to Inherited widget which the provider package uses bts. Inherited widget establishes bts communication tunnels using context*/ {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 30,
      imageURL:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 60,
      imageURL:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 20,
      imageURL:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 50,
      imageURL:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  List<Product> get items {
    return [
      ..._items
    ]; // Copy of _items so that we do not directly edit the original list
  } // Adding getter method as _items is a private property which cannot be accessed from outised this class

  void addProducts() {
    // _items.add(value);
    notifyListeners(); // If we change data in this class, this will help us to communicate these changes to all the widgets.
  }
}
