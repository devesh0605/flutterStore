import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  ProductDetailScreen({this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
    );
  }
}
