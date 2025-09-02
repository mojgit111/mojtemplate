import 'package:ecommerce_mobile/model/ispit.dart';
import 'package:ecommerce_mobile/screens/cart_screen.dart';
import 'package:ecommerce_mobile/screens/ispit_screen.dart';
import 'package:ecommerce_mobile/screens/product_details_screen.dart';
import 'package:ecommerce_mobile/screens/product_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_mobile/screens/proizvodi_komentari_screen.dart';


class MasterScreen extends StatefulWidget {
  const MasterScreen({super.key, required this.child, required this.title});
  final Widget child;
  final String title;

  @override
  State<MasterScreen> createState() => _MasterScreenState();
}

class _MasterScreenState extends State<MasterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text('Back'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Products'),
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => ProductList()));
              },
            ),
            ListTile(
              title: Text('Product Details'),
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProductDetailsScreen()));
              },
            ),
               ListTile(
              title: Text('Ispit Screen'),
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => IspitList()));
              },
            ),
             ListTile(
              title: Text('Product Komentari'),
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProduktKomentariScreen()));
              },
            ),
            ListTile(
              title: Text('Cart'),
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => CartScreen()));
              },
            ),
          ],
        ),
      ),
      body: widget.child,
    );
  }
}
