import 'package:flutter/material.dart';
import 'package:flutter_shop/providers/products_provider.dart';
import 'package:flutter_shop/widgets/custom_drawer.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  //static const routeName = '/product-detail';

  ProductDetailScreen({@required this.id});

  //final String title;
  final String id;

  @override
  Widget build(BuildContext context) {
    final productId =
        ModalRoute.of(context).settings.arguments as String; // is the id!

    var data = Provider.of<Products>(context, listen: false).findById(id);

    return Scaffold(
      // appBar: AppBar(
      //   title: Text(data.title),
      // ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Container(
                color: Colors.black54,
                child: Text(
                  data.title,
                  textAlign: TextAlign.center,
                ),
              ),
              background: Hero(
                tag: data.id,
                child: Image.network(
                  data.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(
                height: 10,
              ),
              Text(
                '\$${data.price}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  data.description,
                  style: TextStyle(color: Colors.black, fontSize: 30),
                  textAlign: TextAlign.center,
                  softWrap: true,
                ),
              ),
              SizedBox(
                height: 800,
              )
            ]),
          )
        ],
      ),
    );
  }
}
