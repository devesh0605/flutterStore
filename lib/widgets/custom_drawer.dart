import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/providers/auth.dart';
import 'package:flutter_shop/screens/orders_screen.dart';
import 'package:flutter_shop/screens/products_overview_screen.dart';
import 'package:flutter_shop/screens/user_products_screen.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              AppBar(
                actions: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
                title: Text('Hey Man'),
                automaticallyImplyLeading: false,
              ),
              // Container(
              //   color: Theme.of(context).primaryColor,
              //   width: double.infinity,
              //   height: 150,
              //   child: Center(
              //     child: Text(
              //       'My Shop',
              //       style: TextStyle(color: Colors.white),
              //     ),
              //   ),
              // ),

              SizedBox(
                height: 10,
              ),
              Divider(
                thickness: 5,
              ),
              FlatButton(
                // color: Colors.grey,
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
              Divider(
                thickness: 5,
              ),
              FlatButton(
                //  color: Colors.grey,
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
              ),
              Divider(
                thickness: 5,
              ),
              FlatButton(
                //  color: Colors.grey,
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    CupertinoPageRoute(
                      builder: (context) {
                        return UserProductsScreen();
                      },
                    ),
                  );
                },
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.edit),
                    SizedBox(
                      width: 5,
                    ),
                    Text('Manage Products'),
                  ],
                ),
              ),
              Divider(
                thickness: 5,
              ),
            ],
          ),
          Column(
            children: [
              Divider(
                thickness: 5,
              ),
              FlatButton(
                //  color: Colors.grey,
                onPressed: () {
                  Navigator.of(context).pop();
                  Provider.of<Auth>(context, listen: false).logout();
                },
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.logout),
                    SizedBox(
                      width: 5,
                    ),
                    Text('LOGOUT'),
                  ],
                ),
              ),
              Divider(
                thickness: 5,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
