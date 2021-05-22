import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_shop/providers/cart.dart';
import 'package:http/http.dart' as http;

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.products,
    @required this.amount,
    @required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> ordersList = [];
  final String authToken;
  final String userId;
  Orders(
      {@required this.ordersList,
      @required this.authToken,
      @required this.userId});

  List<OrderItem> get orders {
    return [...ordersList];
  }

  Future<void> fetchAndSetOrders() async {
    var url = Uri.parse(
        'https://flutter-store-90bbb-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken');

    final response = await http.get(url);
    // print(json.decode(response.body));
    final List<OrderItem> loadedOrders = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }
    extractedData.forEach((key, value) {
      loadedOrders.add(
        OrderItem(
          id: key,
          products: (value['products'] as List<dynamic>).map((e) {
            return CartItem(
                id: e['id'],
                price: e['price'],
                quantity: e['quantity'],
                title: e['title']);
          }).toList(),
          amount: value['amount'],
          dateTime: DateTime.parse(value['dateTime']),
        ),
      );
    });
    ordersList = loadedOrders.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    var url = Uri.parse(
        'https://flutter-store-90bbb-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken');

    final timStamp = DateTime.now();
    final response = await http.post(url,
        body: json.encode({
          'amount': total,
          'dateTime': timStamp.toIso8601String(),
          'products': cartProducts
              .map((e) => {
                    'id': e.id,
                    'title': e.title,
                    'quantity': e.quantity,
                    'price': e.price
                  })
              .toList()
        }));

    ordersList.insert(
      0,
      OrderItem(
        id: json.decode(response.body)['name'],
        products: cartProducts,
        amount: total,
        dateTime: timStamp,
      ),
    );
    notifyListeners();
  }
}
