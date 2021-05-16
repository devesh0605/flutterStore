import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  ProductItem({this.imageUrl, this.title, this.id});
  final String imageUrl;
  final String id;
  final String title;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, CupertinoPageRoute(builder: (context) {
            return ProductDetailScreen(
              title: title,
            );
          }));
        },
        child: GridTile(
          header: GridTileBar(
            backgroundColor: Colors.black54,
            title: Text(
              title,
              textAlign: TextAlign.center,
            ),
          ),
          child: Image.network(
            (imageUrl),
            fit: BoxFit.cover,
          ),
          footer: GridTileBar(
            title: Text(''),
            leading: IconButton(
              color: Theme.of(context).accentColor,
              icon: Icon(Icons.favorite),
              onPressed: () {},
            ),
            trailing: IconButton(
              color: Theme.of(context).accentColor,
              icon: Icon(Icons.shopping_cart),
              onPressed: () {},
            ),
            backgroundColor: Colors.black54,
            // title: Text(
            //   title,
            //   textAlign: TextAlign.center,
            //   style: TextStyle(
            //       // fontSize: 10,
            //       ),
            // ),
          ),
        ),
      ),
    );
  }
}
