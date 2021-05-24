import 'package:flutter/material.dart';
import 'package:flutter_shop/providers/cart.dart';
import 'package:flutter_shop/providers/products_provider.dart';
import 'package:flutter_shop/screens/cart_screen.dart';
import 'package:flutter_shop/widgets/badge.dart';
import 'package:flutter_shop/widgets/custom_drawer.dart';
import 'package:flutter_shop/widgets/product_grid.dart';
import 'package:provider/provider.dart';
import 'package:fullscreen/fullscreen.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showOnlyFavorites = false;
  var _isInit = true;
  var _isLoading = false;
  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });

    // TODO: implement initState

    Provider.of<Products>(context, listen: false)
        .fetchAndSetProducts()
        .then((_) {
      setState(() {
        _isLoading = false;
      });
    });

    super.initState();
  }

  // @override
  // void initState() {
  //   super.initState();
  // }
  //
  // @override
  // void didChangeDependencies() {
  //   if (_isInit) {
  //     setState(() {
  //       _isLoading = true;
  //     });
  //     Future.delayed(Duration(milliseconds: 300)).then((_) async {
  //       await Provider.of<Products>(context, listen: false)
  //           .fetchAndSetProducts()
  //           .then((_) {
  //         setState(() {
  //           _isLoading = false;
  //         });
  //       });
  //     });
  //   }
  //   _isInit = false;
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: Row(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: <Widget>[
      //     FloatingActionButton(
      //       onPressed: () async {
      //         enterFullScreen(FullScreenMode.EMERSIVE_STICKY);
      //       },
      //       child: new Icon(Icons.fullscreen),
      //     ),
      //     FloatingActionButton(
      //       onPressed: () async {
      //         exitFullScreen();
      //       },
      //       child: new Icon(Icons.fullscreen_exit),
      //     ),
      //   ],
      // ),
      appBar: AppBar(
        title: Text('My Shop'),
        actions: <Widget>[
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              child: ch,
              value: cart.cartCount.toString(),
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                //Navigator.pushNamed(context, CartScreen.routeName);
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return CartScreen();
                }));
              },
            ),
          ),
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorites) {
                  _showOnlyFavorites = true;
                } else {
                  _showOnlyFavorites = false;
                }
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) {
              return [
                PopupMenuItem(
                  child: Text(
                    'Only Favorites',
                  ),
                  value: FilterOptions.Favorites,
                ),
                PopupMenuItem(
                  child: Text(
                    'Show All',
                  ),
                  value: FilterOptions.All,
                ),
              ];
            },
          ),
        ],
      ),
      drawer: CustomDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                  //backgroundColor: Colors.black,
                  ))
          : GridViewBuilder(
              showOnlyFavorites: _showOnlyFavorites,
            ),
    );
  }
}
