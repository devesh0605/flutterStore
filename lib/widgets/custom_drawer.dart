import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/screens/orders_screen.dart';
import 'package:flutter_shop/screens/products_overview_screen.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Hey Man'),
            automaticallyImplyLeading: false,
          ),
          Container(
            color: Theme.of(context).primaryColor,
            width: double.infinity,
            height: 150,
            child: Center(
              child: Text(
                'My Shop',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          FlatButton(
            color: Colors.grey,
            onPressed: () {
              Navigator.pushReplacement(
                context,
                CupertinoPageRoute(
                  builder: (context) {
                    return OrderScreen();
                  },
                ),
              );
            },
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.shopping_cart),
                SizedBox(
                  width: 5,
                ),
                Text('You Orders'),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          FlatButton(
            color: Colors.grey,
            onPressed: () {
              Navigator.pushReplacement(
                context,
                CupertinoPageRoute(
                  builder: (context) {
                    return ProductOverviewScreen();
                  },
                ),
              );
            },
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.shop),
                SizedBox(
                  width: 5,
                ),
                Text('Back to Shop'),
              ],
            ),
          )
        ],
      ),
    );
  }
}
