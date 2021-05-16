import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/providers/product.dart';
import 'package:flutter_shop/screens/product_detail_screen.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productDetail = Provider.of<Product>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(
            ProductDetailScreen.routeName,
            arguments: productDetail.id,
          );
        },
        child: GridTile(
          header: GridTileBar(
            backgroundColor: Colors.black54,
            title: Text(
              productDetail.title,
              textAlign: TextAlign.center,
            ),
          ),
          child: FadeInImage.assetNetwork(
            placeholder: 'assets/images/placeholder.png',
            image: productDetail.imageUrl,
            fit: BoxFit.cover,
          ),
          footer: GridTileBar(
            title: Text(''),
            leading: Consumer<Product>(
              builder: (ctx, product, child) => IconButton(
                color: Theme.of(context).accentColor,
                icon: Icon(
                  productDetail.isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border,
                ),
                onPressed: () {
                  productDetail.toggleFavoriteStatus();
                },
              ),
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
