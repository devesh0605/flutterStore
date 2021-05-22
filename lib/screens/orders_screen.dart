import 'package:flutter/material.dart';
import 'package:flutter_shop/providers/orders.dart';
import 'package:flutter_shop/widgets/custom_drawer.dart';
import 'package:flutter_shop/widgets/order_item.dart' as oi;
import 'package:provider/provider.dart';

class OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  //@override
  // void initState() {
  //   _isLoading = true;
  //
  //   Provider.of<Orders>(context, listen: false).fetchAndSetOrders().then((_) {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   });
  //
  //   // TODO: implement initState
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    //final orderDetails = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: CustomDrawer(),
      body: RefreshIndicator(
        onRefresh: () async {
          await Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
        },
        child: FutureBuilder(
            future:
                Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
            builder: (ctx, dataSnapshot) {
              print(dataSnapshot);
              if (dataSnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                if (dataSnapshot.error != null) {
                  return Center(
                    child: Text(
                      'Something is wrong!!',
                    ),
                  );
                } else {
                  return Consumer<Orders>(
                    builder: (ctx, orderDetails, child) => ListView.builder(
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
            }),
      ),
    );
  }
}
