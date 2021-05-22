import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/providers/auth.dart';
import 'package:flutter_shop/providers/cart.dart';
import 'package:flutter_shop/providers/product.dart';
import 'package:flutter_shop/screens/product_detail_screen.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authDetails = Provider.of<Auth>(context, listen: false);
    final productDetail = Provider.of<Product>(context, listen: false);
    final cartDetail = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GestureDetector(
        onTap: () {
          // Navigator.of(context).pushNamed(
          //   ProductDetailScreen.routeName,
          //   arguments: productDetail.id,
          // );
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ProductDetailScreen(id: productDetail.id);
          }));
        },
        child: GridTile(
          header: GridTileBar(
            backgroundColor: Colors.black54,
            title: Text(
              productDetail.title,
              textAlign: TextAlign.center,
            ),
          ),
          child: Image.network(
            productDetail.imageUrl,
            fit: BoxFit.cover,
            // loadingBuilder: (BuildContext context, Widget child,
            //     ImageChunkEvent loadingProgress) {
            //   if (loadingProgress == null) {
            //     return child;
            //   }
            //   return Center(
            //     child: CircularProgressIndicator(
            //       value: loadingProgress.expectedTotalBytes != null
            //           ? loadingProgress.cumulativeBytesLoaded /
            //               loadingProgress.expectedTotalBytes
            //           : null,
            //     ),
            //   );
            // },
            errorBuilder: (
              BuildContext context,
              Object error,
              StackTrace stackTrace,
            ) {
              return Image.asset(
                'assets/images/error.jpg',
                fit: BoxFit.cover,
              );
            },
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
                  productDetail.toggleFavoriteStatus(
                    context,
                    authDetails.token,
                    authDetails.userId,
                  );
                },
              ),
            ),
            trailing: IconButton(
              color: Theme.of(context).accentColor,
              icon: Icon(Icons.shopping_cart_outlined),
              onPressed: () {
                cartDetail.addItem(
                    price: productDetail.price,
                    title: productDetail.title,
                    productId: productDetail.id);
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    'Added Item to cart',
                  ),
                  duration: Duration(seconds: 5),
                  action: SnackBarAction(
                    label: 'UNDO',
                    onPressed: () {
                      cartDetail.removeSingleItem(productDetail.id);
                    },
                  ),
                ));
                //Scaffold.of(context).showSnackBar(snackbar);
              },
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
