import 'package:ecommerce_desktop/model/ispit.dart';
import 'package:ecommerce_desktop/screens/ispit_screen.dart';
import 'package:ecommerce_desktop/screens/komentati_proizvod_screen.dart';
import 'package:ecommerce_desktop/screens/product_details_screen.dart';
import 'package:ecommerce_desktop/screens/product_list.dart';
import 'package:ecommerce_desktop/screens/proizvod_komentari_screen.dart';
import 'package:flutter/material.dart';

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
              title: Text('Ispit'),
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Ispit30062022()));
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
              title: Text('Komentari proizvodi'),
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => KomentariProizvodList()));
              },
            ),    
                ListTile(
              title: Text('Proizvodi komentari'),
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProizvodKomentariScreen()));
                     
              },
            ),
        ],
        ),
      ),
      body: widget.child,
    );
  }
}
