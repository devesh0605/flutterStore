import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/models/http_exception.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;
  Product({
    @required this.id,
    @required this.title,
    @required this.imageUrl,
    @required this.description,
    @required this.price,
    this.isFavorite = false,
  });

  Future<void> toggleFavoriteStatus(BuildContext context) async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    var url = Uri.parse(
        'https://flutter-store-90bbb-default-rtdb.firebaseio.com/products/$id.json');

    try {
      final response = await http.patch(url,
          body: json.encode({
            'isFavorite': isFavorite,
          }));
      if (response.statusCode >= 400) {
        isFavorite = oldStatus;
        notifyListeners();
        throw HttpException(message: 'Some error occurred');
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Unable to toggle. Error occurred.'),
      ));
      isFavorite = oldStatus;
      notifyListeners();
    }
  }
}
