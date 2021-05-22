import 'package:flutter/material.dart';
import 'package:flutter_shop/models/http_exception.dart';
import 'package:flutter_shop/providers/product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Products with ChangeNotifier {
  List<Product> items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];
  final String authToken;
  final String userId;
  Products({@required this.authToken, this.items, @required this.userId});

  List<Product> get item {
    return [...items];
  }

  List<Product> get favoriteItems {
    return items.where((element) => element.isFavorite).toList();
  }

  Product findById(String id) {
    return items.firstWhere((element) => element.id == id);
  }

  Future<void> addProduct(Product product) async {
    var url = Uri.parse(
        'https://flutter-store-90bbb-default-rtdb.firebaseio.com/products.json?auth=$authToken');
    try {
      final response = await http.post(url,
          body: jsonEncode({
            'title': product.title,
            'description': product.description,
            'price': product.price,
            'imageUrl': product.imageUrl,
            //'isFavorite': product.isFavorite
          }));
      final newProduct = Product(
        //id: DateTime.now().toString(),
        id: jsonDecode(response.body)['name'],
        title: product.title,
        imageUrl: product.imageUrl,
        description: product.description,
        price: product.price,
      );
      items.add(newProduct);
      notifyListeners();
    } catch (error) {
      print(error);
      throw (error);
    }

    // final newProduct = Product(
    //   id: DateTime.now().toString(),
    //   title: product.title,
    //   imageUrl: product.imageUrl,
    //   description: product.description,
    //   price: product.price,
    // );
    // _items.add(newProduct);
    // notifyListeners();
  }

  Future<void> fetchAndSetProducts() async {
    var url = Uri.parse(
        'https://flutter-store-90bbb-default-rtdb.firebaseio.com/products.json?auth=$authToken');

    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      final List<Product> loadedProducts = [];
      if (extractedData == null) {
        return;
      }
      url = Uri.parse(
          'https://flutter-store-90bbb-default-rtdb.firebaseio.com/userFavorites/$userId.json?auth=$authToken');
      final favoriteResponse = await http.get(url);
      final favoriteData = json.decode(favoriteResponse.body);
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(
          Product(
            id: prodId,
            title: prodData['title'],
            imageUrl: prodData['imageUrl'],
            description: prodData['description'],
            price: double.parse(prodData['price'].toString()),
            isFavorite:
                favoriteData == null ? false : favoriteData[prodId] ?? false,
          ),
        );
      });
      items = loadedProducts;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = items.indexWhere((element) => element.id == id);
    if (prodIndex >= 0) {
      var url = Uri.parse(
          'https://flutter-store-90bbb-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken');
      await http.patch(url,
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
            'imageUrl': newProduct.imageUrl,
            'price': newProduct.price
          }));

      items[prodIndex] = newProduct;
    } else {
      print('....');
    }

    notifyListeners();
  }

  Future<void> deleteProducts(String id) async {
    var url = Uri.parse(
        'https://flutter-store-90bbb-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken');
    final existingProductIndex =
        items.indexWhere((element) => element.id == id);
    var existingProduct = items[existingProductIndex];
    items.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException(
        message: 'Could not delete product.',
      );
    }

    existingProduct = null;
  }
}
