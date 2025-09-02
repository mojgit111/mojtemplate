import 'package:ecommerce_desktop/layouts/master_screen.dart';
import 'package:ecommerce_desktop/model/ispit.dart';
import 'package:ecommerce_desktop/model/product.dart';
import 'package:ecommerce_desktop/model/search_result.dart';
import 'package:ecommerce_desktop/providers/ispit_provider.dart';
import 'package:ecommerce_desktop/providers/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_desktop/providers/product_provider.dart';

class Ispit30062022 extends StatefulWidget {
  const Ispit30062022({super.key});

  @override
  State<Ispit30062022> createState() => _Ispit30062022State();
}

class _Ispit30062022State extends State<Ispit30062022> {
  late IspitProvider ispitProvider;
  late ProductProvider productProvider;

  TextEditingController minAmountController = TextEditingController();
  int? selectedProductId;
  SearchResult<Ispit>? ispiti;
  SearchResult<Product>? products;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ispitProvider = context.read<IspitProvider>();
    productProvider = context.read<ProductProvider>();
    loadProducts(); // ✅ Premjestio ovdje
  }

  // ❌ Uklonio initState

  void loadProducts() async {
    products = await productProvider.get();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "Ispit30062022",
      child: Column(
        children: [
          _buildSearch(),
          _buildResultView(),
          // _buildTotal(), // ✅ Privremeno uklonio
        ],
      ),
    );
  }

  Widget _buildSearch() {
  return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: DropdownButtonFormField<int>(
              value: selectedProductId,
              items: products?.items?.map((product) =>
                DropdownMenuItem(
                  value: product.id,
                  child: Text(product.name)
                )
              ).toList() ?? [],
              onChanged: (value) {
                selectedProductId = value;
                setState(() {});
              },
              decoration: InputDecoration(
                labelText: "Select Product",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Minimal Amount",
                border: OutlineInputBorder(),
              ),
              controller: minAmountController,
              keyboardType: TextInputType.number,
            ),
          ),
          SizedBox(width: 10),
          ElevatedButton(
            onPressed: () async {
              var filter = {
                "productId": selectedProductId,
                "minimalanIznosNarudzbe": double.tryParse(minAmountController.text),
              };
              debugPrint("Filter: $filter");
              
              var ispiti = await ispitProvider.get(filter: filter);
              
              // ✅ Dodajte detaljan debug
              debugPrint("Total items: ${ispiti.items?.length}");
              if (ispiti.items?.isNotEmpty == true) {
                var first = ispiti.items!.first;
                debugPrint("First item ID: ${first.id}");
                debugPrint("User ID: ${first.userId}");
                debugPrint("User: ${first.user?.firstName} ${first.user?.lastName}");
                debugPrint("Product ID: ${first.productId}");
                debugPrint("Product: ${first.product?.name}");
                debugPrint("Min amount: ${first.minimalanIznosNarudzbe}");
                debugPrint("Order count: ${first.brojNarudzbe}");
                debugPrint("Order amount: ${first.IznosNarudzbe}"); // ✅ Ispravio ime
              }
              
              this.ispiti = ispiti;
              setState(() {});
            },
            child: Text("Search"),
          ),
        ],
      ));
}
Widget _buildResultView() {
  if (ispiti?.items == null || ispiti!.items!.isEmpty) {
    return Expanded(
      child: Center(
        child: Text("No data found"),
      ),
    );
  }

  return Expanded(child: Container(
    width: double.infinity,
    child: SingleChildScrollView(
      child: DataTable(
        columns: [
          DataColumn(label: Text("User")),
          DataColumn(label: Text("Product")),
          DataColumn(label: Text("Min Amount")),
          DataColumn(label: Text("Order Count")),
          DataColumn(label: Text("Order Amount")),
        ],
        rows: ispiti!.items!.map((e) => DataRow(
          cells: [
            DataCell(Text("${e.user?.firstName ?? ''} ${e.user?.lastName ?? ''}")),
            DataCell(Text(e.product?.name ?? 'N/A')),
            DataCell(Text(e.minimalanIznosNarudzbe?.toString() ?? '0')),
            DataCell(Text(e.brojNarudzbe?.toString() ?? '0')),
            DataCell(Text(e.IznosNarudzbe?.toString() ?? '0')),
          ])).toList(),
      ),
    ),
  ));
}
  // ❌ Privremeno uklonio _buildTotal() da izbjegnem greške
}