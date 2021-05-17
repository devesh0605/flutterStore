import 'package:flutter/material.dart';
import 'package:flutter_shop/providers/cart.dart';
import 'package:flutter_shop/providers/orders.dart';
import 'package:flutter_shop/widgets/custom_drawer.dart';
import 'package:provider/provider.dart';
import 'package:flutter_shop/widgets/cart_item.dart' as ci;

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  @override
  Widget build(BuildContext context) {
    final cartDetails = Provider.of<Cart>(context);
    final orderDetails = Provider.of<Orders>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      drawer: CustomDrawer(),
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
                  // ignore: deprecated_member_use
                  FlatButton(
                    onPressed: () {
                      orderDetails.addOrder(cartDetails.items.values.toList(),
                          cartDetails.totalAmount);
                      cartDetails.clearCart();
                    },
                    child: Text(
                      'ORDER NOW',
                    ),
                    textColor: Theme.of(context).primaryColor,
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cartDetails.items.length,
              itemBuilder: (ctx, index) {
                return ci.CartItem(
                  productId: cartDetails.items.keys.toList()[index],
                  id: cartDetails.items.values.toList()[index].id,
                  title: cartDetails.items.values.toList()[index].title,
                  price: cartDetails.items.values.toList()[index].price,
                  quantity: cartDetails.items.values.toList()[index].quantity,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
