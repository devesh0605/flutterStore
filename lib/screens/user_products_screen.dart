import 'package:flutter/material.dart';
import 'package:flutter_shop/providers/products_provider.dart';
import 'package:flutter_shop/screens/edit_product_screen.dart';
import 'package:flutter_shop/widgets/custom_drawer.dart';
import 'package:flutter_shop/widgets/user_product_item.dart';
import 'package:provider/provider.dart';

class UserProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productDetails = Provider.of<Products>(context);
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text('Your Products'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return EditProductScreen();
              }));
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
            itemCount: productDetails.item.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  UserProductItem(
                    productId: productDetails.item[index].id,
                    title: productDetails.item[index].title,
                    imageUrl: productDetails.item[index].imageUrl,
                  ),
                  Divider(
                    thickness: 5,
                  ),
                ],
              );
            }),
      ),
    );
  }
}
