import 'package:flutter/material.dart';
import 'package:flutter_shop/providers/auth.dart';
import 'package:flutter_shop/providers/cart.dart';
import 'package:flutter_shop/providers/orders.dart';
import 'package:flutter_shop/providers/products_provider.dart';
import 'package:flutter_shop/screens/auth_screen.dart';
import 'package:flutter_shop/screens/cart_screen.dart';
import 'package:flutter_shop/screens/product_detail_screen.dart';
import 'package:flutter_shop/screens/products_overview_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: null,
          update: (ctx, auth, previousProducts) => Products(
              authToken: auth.token,
              items: previousProducts == null ? [] : previousProducts.items),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Orders(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, authData, _) {
          return MaterialApp(
            title: 'Shop',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.purple[200],
              backgroundColor: Colors.purple[200],
              appBarTheme: AppBarTheme(
                centerTitle: true,
              ),
              primarySwatch: Colors.purple,
              accentColor: Colors.orange,
            ),
            home: authData.isAuth ? ProductOverviewScreen() : AuthScreen(),
            //initialRoute: '/',
            //home: ProductOverviewScreen(),
            // routes: {
            //   '/': (ctx) => ProductOverviewScreen(),
            //   ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            //   CartScreen.routeName: (ctx) => CartScreen(),
            // },
          );
        },
        // child: MaterialApp(
        //   title: 'Shop',
        //   debugShowCheckedModeBanner: false,
        //   theme: ThemeData(
        //     scaffoldBackgroundColor: Colors.purple[200],
        //     backgroundColor: Colors.purple[200],
        //     appBarTheme: AppBarTheme(
        //       centerTitle: true,
        //     ),
        //     primarySwatch: Colors.purple,
        //     accentColor: Colors.orange,
        //   ),
        //   home: AuthScreen(),
        //   //initialRoute: '/',
        //   //home: ProductOverviewScreen(),
        //   // routes: {
        //   //   '/': (ctx) => ProductOverviewScreen(),
        //   //   ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
        //   //   CartScreen.routeName: (ctx) => CartScreen(),
        //   // },
        // ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop App'),
        centerTitle: true,
      ),
      body: Center(
        child: Text('Let\'s Buy'),
      ),
    );
  }
}
