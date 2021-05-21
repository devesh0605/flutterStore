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
                    'Total=>',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),

                  Chip(
                    label: Text(
                      '\$ ${cartDetails.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  // ignore: deprecated_member_use
                  Spacer(),
                  MyFlatButton(
                      cartDetails: cartDetails, orderDetails: orderDetails)
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

class MyFlatButton extends StatefulWidget {
  const MyFlatButton({
    Key key,
    @required this.cartDetails,
    @required this.orderDetails,
  }) : super(key: key);

  final Cart cartDetails;
  final Orders orderDetails;

  @override
  _MyFlatButtonState createState() => _MyFlatButtonState();
}

class _MyFlatButtonState extends State<MyFlatButton> {
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style:
          ButtonStyle(backgroundColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.pressed)) return Colors.black;
          return null; // Use the component's default.
        },
      )),
      onPressed: (widget.cartDetails.totalAmount == 0 || _isLoading)
          ? null
          : () async {
              setState(() {
                _isLoading = true;
              });
              await widget.orderDetails.addOrder(
                  widget.cartDetails.items.values.toList(),
                  widget.cartDetails.totalAmount);
              setState(() {
                _isLoading = false;
              });
              widget.cartDetails.clearCart();
            },
      child: _isLoading
          ? CircularProgressIndicator()
          : Text(
              widget.cartDetails.totalAmount == 0 ? 'CART EMPTY' : 'ORDER NOW',
              style: TextStyle(
                  color: widget.cartDetails.totalAmount == 0
                      ? Colors.black
                      : Colors.white),
            ),
    );
  }
}
