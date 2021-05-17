import 'package:flutter/material.dart';
import 'package:flutter_shop/providers/cart.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  @override
  Widget build(BuildContext context) {
    final cartDetails = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your CArt'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      '\$ ${cartDetails.totalAmount}',
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  FlatButton(
                    onPressed: () {},
                    child: Text(
                      'ORDER NOW',
                    ),
                    textColor: Theme.of(context).primaryColor,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
