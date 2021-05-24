import 'package:flutter/material.dart';
import 'package:flutter_shop/providers/auth.dart';
import 'package:flutter_shop/providers/cart.dart';
import 'package:flutter_shop/providers/orders.dart';
import 'package:flutter_shop/providers/products_provider.dart';
import 'package:flutter_shop/screens/auth_screen.dart';
import 'package:flutter_shop/screens/products_overview_screen.dart';
import 'package:flutter_shop/screens/splash_screen.dart';
import 'package:flutter_shop/screens/testtwo.dart';
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
              auth.userId,
              auth.token,
              previousProducts == null ? [] : previousProducts.item),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: null,
          update: (ctx, auth, previousOrders) => Orders(
              ordersList: previousOrders == null ? [] : previousOrders.orders,
              authToken: auth.token,
              userId: auth.userId),
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
            //home: Test(),
            //home: TestTwo(),
            home: authData.isAuth
                ? ProductOverviewScreen()
                : FutureBuilder(
                    future: authData.tryAutoLogin(),
                    builder: (ctx, authResultSnapshot) =>
                        authResultSnapshot.connectionState ==
                                ConnectionState.waiting
                            ? SplashScreen()
                            : AuthScreen(),
                  ),
            //initialRoute: '/',
            //home: ProductOverviewScreen(),
            // routes: {
            //   '/': (ctx) => ProductOverviewScreen(),
            //   ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            //   CartScreen.routeName: (ctx) => CartScreen(),
            // },
            // home: Scaffold(
            //   appBar: AppBar(
            //     title: Text('Shop App'),
            //     centerTitle: true,
            //   ),
            //   body: Builder(
            //     builder: (context) {
            //       return Column(
            //         children: [
            //           Center(
            //             child: FlatButton(
            //               child: Text('Click me'),
            //               onPressed: () {
            //                 Navigator.push(context,
            //                     MaterialPageRoute(builder: (context) {
            //                   return MyHomePage2();
            //                 }));
            //               },
            //             ),
            //           ),
            //           Center(
            //             child: FlatButton(
            //               child: Text('Click me'),
            //               onPressed: () {
            //                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            //                   content: Text('Some Message'),
            //                   action: SnackBarAction(
            //                     label: 'UNDO',
            //                     onPressed: () {
            //                       ScaffoldMessenger.of(context)
            //                           .hideCurrentSnackBar();
            //                     },
            //                   ),
            //                 ));
            //               },
            //             ),
            //           ),
            //         ],
            //       );
            //     },
            //   ),
            // ),
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
        child: FlatButton(
          child: Text('Click me'),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return MyHomePage2();
            }));
          },
        ),
      ),
    );
  }
}

class MyHomePage2 extends StatelessWidget {
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
