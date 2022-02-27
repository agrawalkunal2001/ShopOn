import 'package:flutter/material.dart';
import 'package:shopon/screens/orders_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text(
              "Hello",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 28,
              ),
            ),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.shop,
              size: 30,
            ),
            title: Text("Shop",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            onTap: () {
              Navigator.of(context).pushReplacementNamed("/");
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.payment,
              size: 30,
            ),
            title: Text("Orders",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(OrdersScreen.routeName);
            },
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.all(15),
            child: Text(
              "\u{00a9} 2022 Kunal Agrawal",
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
