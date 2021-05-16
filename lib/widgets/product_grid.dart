import 'package:flutter/material.dart';
import 'package:flutter_shop/providers/products_provider.dart';
import 'package:flutter_shop/widgets/product_item.dart';
import 'package:provider/provider.dart';

class GridViewBuilder extends StatelessWidget {
  final bool showOnlyFavorites;
  GridViewBuilder({this.showOnlyFavorites});
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products =
        showOnlyFavorites ? productsData.favoriteItems : productsData.item;
    return Scrollbar(
      isAlwaysShown: true,
      showTrackOnHover: true,
      child: GridView.builder(
        itemCount: products.length,
        padding: const EdgeInsets.all(20),
        itemBuilder: (ctx, index) {
          return ChangeNotifierProvider.value(
              value: products[index],
              // create: (c) {
              //   return products[index];
              // },
              child: ProductItem());
        },
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
          childAspectRatio: 1 / 1,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
      ),
    );
  }
}
