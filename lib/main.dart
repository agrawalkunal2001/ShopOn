import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopon/providers/auth.dart';
import 'package:shopon/providers/products_cart.dart';
import 'package:shopon/providers/products_order.dart';
import 'package:shopon/providers/products_provider.dart';
import 'package:shopon/screens/auth_screen.dart';
import 'package:shopon/screens/cart_screen.dart';
import 'package:shopon/screens/edit_product_screen.dart';
import 'package:shopon/screens/orders_screen.dart';
import 'package:shopon/screens/product_detail_screen.dart';
import 'package:shopon/screens/products_overview_screen.dart';
import 'package:shopon/screens/user_products_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          // It allows us to register a class to listen the changes in widgets and when the class updtaes the listening widgets will update.
          create: (ctx) => ProductsProvider(),
        ), // All child widgets can now set up a listener to this instance of the class.
        ChangeNotifierProvider(
          create: (ctx) => ProductsCart(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => ProductsOrder(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "ShopOn",
        theme: ThemeData(
            primarySwatch: Colors.teal,
            accentColor: Colors.deepOrange,
            fontFamily: "Lato"),
        home: AuthScreen(),
        routes: {
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
          OrdersScreen.routeName: (ctx) => OrdersScreen(),
          UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
          EditProductScreen.routeName: (ctx) => EditProductScreen(),
          AuthScreen.routeName: (ctx) => AuthScreen(),
        },
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ShopOn"),
      ),
    );
  }
}
