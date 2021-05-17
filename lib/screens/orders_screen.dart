import 'package:flutter/material.dart';
import 'package:flutter_shop/providers/orders.dart';
import 'package:flutter_shop/widgets/custom_drawer.dart';
import 'package:flutter_shop/widgets/order_item.dart' as oi;
import 'package:provider/provider.dart';

class OrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final orderDetails = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: CustomDrawer(),
      body: ListView.builder(
        itemCount: orderDetails.orders.length,
        itemBuilder: (ctx, index) {
          return oi.OrderItem(
            order: orderDetails.orders[index],
          );
        },
      ),
    );
  }
}
