import 'package:ecommerce_mobile/layouts/master_screen.dart';
import 'package:ecommerce_mobile/model/cart_provider.dart';
import 'package:ecommerce_mobile/model/ispit.dart';
import 'package:ecommerce_mobile/model/product.dart';
import 'package:ecommerce_mobile/model/search_result.dart';
import 'package:ecommerce_mobile/model/user.dart';
import 'package:ecommerce_mobile/providers/ispit_provider.dart';
import 'package:ecommerce_mobile/providers/user_provider.dart';
import 'package:ecommerce_mobile/providers/utils.dart';
import 'package:ecommerce_mobile/screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_mobile/providers/product_provider.dart';

class IspitList extends StatefulWidget {
  const IspitList({super.key});

  @override
  State<IspitList> createState() => _IspitListScreen();
}

class _IspitListScreen extends State<IspitList> {
  late IspitProvider ispitProvider;
  TextEditingController searchController = TextEditingController();

  SearchResult<Ispit>? data;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    ispitProvider = context.read<IspitProvider>();
    loadData();
  }

  void loadData() async {
    var ispiti = await ispitProvider.get(filter: {
      "fts": "",
    });
    this.data = ispiti;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "User List",
      child: Center(
        child: Column(
          children: [_buildSearch(), _buildResultView()],
        ),
      ),
    );
  }

  Widget _buildSearch() {
    return Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search",
                  border: OutlineInputBorder(),
                ),
                controller: searchController,
              ),
            ),
            SizedBox(width: 10),
            ElevatedButton(
              onPressed: () async {
                var filter = {
                  "fts": searchController.text,
                };
                debugPrint(filter.toString());
                var users = await ispitProvider.get(filter: filter);
                this.data = users;
                setState(() {});
              },
              child: Text("Search"),
            ),
            SizedBox(width: 10),
          ],
        ));
  }

  Widget _buildResultView() {
    return Expanded(
        child: Container(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Container(
          height: 500,
          child: GridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 4 / 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 30),
            scrollDirection: Axis.horizontal,
            children: _buildUserCardList(),
          ),
        ),
      ),
    ));
  }

/*
  List<Widget> _buildUserCardList() {
    print("Building user card list");
    print("Data: $data");
    print("Items counts: ${data?.items?.length}");
    if (data == null || data?.items?.length == 0) {
      return [Text("Loading...")];
    }
    List<Widget> list = data!.items!
        .map((x) => Container(
              child: Column(
                children: [
                  Container(
                    height: 100,
                    width: 100,
                  ),
                  Text(x.user?.firstName?? "No name"),
                  Text(x.user?.lastName?? "No last name"),
                  IconButton(onPressed: () {}, icon: Icon(Icons.info))
                ],
              ),
            ))
        .cast<Widget>()
        .toList();

    return list;
  }
  */
  List<Widget> _buildUserCardList() {
  print("Building user card list");
  print("Data: $data");
  print("Items counts: ${data?.items?.length}");
  
  if (data == null || data?.items?.length == 0) {
    return [Text("No users found...")];  // ✅ Promijenite tekst
  }
  
  List<Widget> list = data!.items!
      .map((x) => Container(
            padding: EdgeInsets.all(8),  // ✅ Dodajte padding
            decoration: BoxDecoration(  // ✅ Dodajte dekoraciju
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,  // ✅ Centrirajte sadržaj
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(  // ✅ Dodajte avatar
                    color: Colors.blue[100],
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.person, size: 30, color: Colors.blue[700]),
                ),
                SizedBox(height: 8),  // ✅ Dodajte razmak
                Text(
                  x.user?.firstName ?? "No name",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                Text(
                  x.user?.lastName ?? "No last name",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 4),  // ✅ Dodajte razmak
                Text(
                  x.user?.email ?? "No email",  // ✅ Dodajte email
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "ID: ${x.user?.id ?? 'N/A'}",  // ✅ Dodajte ID
                  style: TextStyle(fontSize: 10, color: Colors.grey[500]),
                ),
                SizedBox(height: 8),  // ✅ Dodajte razmak
                IconButton(
                  onPressed: () {
                    // Navigacija na user detalje
                  }, 
                  icon: Icon(Icons.info, color: Colors.blue)
                )
              ],
            ),
          ))
      .cast<Widget>()
      .toList();

  return list;
}
}
