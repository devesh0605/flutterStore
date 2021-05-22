import 'package:flutter/cupertino.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.price,
    @required this.quantity,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _item = {};

  Map<String, CartItem> get items {
    return {..._item};
  }

  int get cartCount {
    return _item == null ? 0 : _item.length;
  }

  double get totalAmount {
    var total = 0.0;
    _item.forEach((key, value) {
      total = total + (value.price * value.quantity);
    });
    return total;
  }

  void addItem({
    @required String productId,
    @required double price,
    @required String title,
  }) {
    if (_item.containsKey(productId)) {
      _item.update(
        productId,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          title: existingCartItem.title,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity + 1,
        ),
      );
    } else {
      _item.putIfAbsent(
          productId,
          () => CartItem(
              id: (DateTime.now().toString()),
              title: title,
              price: price,
              quantity: 1));
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _item.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_item.containsKey(productId)) {
      return;
    }
    if (_item[productId].quantity > 1) {
      _item.update(
          productId,
          (existingCartItem) => CartItem(
                id: existingCartItem.id,
                title: existingCartItem.title,
                price: existingCartItem.price,
                quantity: existingCartItem.quantity - 1,
              ));
    } else {
      _item.remove(productId);
    }
    notifyListeners();
  }

  void clearCart() {
    _item = {};
    notifyListeners();
  }
}
