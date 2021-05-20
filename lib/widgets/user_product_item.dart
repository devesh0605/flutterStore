import 'package:flutter/material.dart';
import 'package:flutter_shop/providers/products_provider.dart';
import 'package:flutter_shop/screens/edit_product_screen.dart';
import 'package:provider/provider.dart';

class UserProductItem extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String productId;
  UserProductItem({this.title, this.imageUrl, @required this.productId});

  @override
  Widget build(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(
          imageUrl,
        ),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            CircleAvatar(
              child: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditProductScreen(
                                productId: productId,
                              )));
                },
                color: Colors.green,
              ),
              backgroundColor: Colors.white,
            ),
            SizedBox(
              width: 5,
            ),
            CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () async {
                  try {
                    await Provider.of<Products>(context, listen: false)
                        .deleteProducts(productId);
                  } catch (error) {
                    scaffold.showSnackBar(SnackBar(
                      content: Text('Deleting failed. Some error occurred.'),
                    ));
                  }
                },
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
