import 'dart:convert';
import 'dart:io';

import 'package:ecommerce_desktop/layouts/master_screen.dart';
import 'package:ecommerce_desktop/model/komentari_proizvod.dart';
import 'package:ecommerce_desktop/model/product.dart';
import 'package:ecommerce_desktop/model/product_type.dart';
import 'package:ecommerce_desktop/model/search_result.dart';
import 'package:ecommerce_desktop/model/unit_of_measure.dart';
import 'package:ecommerce_desktop/providers/komentari_proizvod_provider.dart';
import 'package:ecommerce_desktop/providers/product_provider.dart';
import 'package:ecommerce_desktop/providers/product_type_provider.dart';
import 'package:ecommerce_desktop/providers/unit_of_measure_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:file_picker/file_picker.dart';

class KomentariProizvodList extends StatefulWidget {
  Product? product;
  KomentariProizvod? komentariProizvod;
  KomentariProizvodList({super.key, this.product});

  @override
  State<KomentariProizvodList> createState() => _KomentariProizvodScreenState();
}

class _KomentariProizvodScreenState extends State<KomentariProizvodList> {
  final formKey = GlobalKey<FormBuilderState>();

  Map<String, dynamic> _initalValue = {};

  late ProductProvider productProvider;
  late UnitOfMeasureProvider unitOfMeasureProvider;
  late int odabraniProizvodId;
  late ProductTypeProvider productTypeProvider;
  late KomentariProizvodProvider komentariProizvodProvider;
  SearchResult<UnitOfMeasure>? unitOfMeasures;
  SearchResult<Product>? products;
  SearchResult<KomentariProizvod>? komentari;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    productProvider = Provider.of<ProductProvider>(context, listen: false);
    unitOfMeasureProvider =
        Provider.of<UnitOfMeasureProvider>(context, listen: false);
    productTypeProvider =
        Provider.of<ProductTypeProvider>(context, listen: false);
    komentariProizvodProvider =
        Provider.of<KomentariProizvodProvider>(context, listen: false);

    _initalValue = {
      "prouductId": null, // ← null je OK
      "komentarKorisnika": '',
    };
    print(_initalValue);

    initFormData();
  }

  initFormData() async {
    products = await productProvider.get();
    komentari = await komentariProizvodProvider.get();

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "Komentari proizvod",
      child: Column(
        children: [
          _buildForm(),
          _buildResultView(),
        ],
      ),
    );
  }

  Widget _buildResultView() {
    return Expanded(
        child: Container(
      width: double.infinity,
      child: SingleChildScrollView(
        child: DataTable(
          columns: [
            DataColumn(label: Text("Ime produkta")),
            DataColumn(label: Text("Datum komentara")),
            DataColumn(label: Text("Komentar korisnika"))
          ],
          rows: komentari?.items
                  ?.map((e) => DataRow(cells: [
                        DataCell(Text(e.product?.name ?? '')),
                        DataCell(Text(e.datumKreiranjaKomentara.toString())),
                        DataCell(Text(e.komentarKorisnika)),
                      ]))
                  .toList() ??
              [],
        ),
      ),
    ));
  }

  File? _image;
  String? _base64Image;

  Widget _buildForm() {
    return FormBuilder(
      key: formKey,
      initialValue: _initalValue,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            FormBuilderTextField(
              name: "komentarKorisnika",
              decoration: InputDecoration(labelText: "Komentar"),
            ),
            Row(
              children: [
                Expanded(
                  child: FormBuilderDropdown<int>(
                    name: "prouductId",
                    decoration: InputDecoration(labelText: "Naziv proizvoda"),
                    items: products?.items
                            ?.map((e) => DropdownMenuItem(
                                  value: e.id,
                                  child: Text(e.name),
                                ))
                            .toList() ??
                        [],
                    onChanged: (value) {
                      setState(() {
                        odabraniProizvodId = value ?? 0;
                      });
                    }, // ✅ Zatvorite onChanged callback
                  ),
                ),
              ],
            ),
            // ✅ Save button treba da bude ovde, van dropdown-a
            ElevatedButton(
              onPressed: () async {
                print("DEBUG: Save button clicked");

                formKey.currentState?.saveAndValidate();
                if (formKey.currentState?.validate() ?? false) {
                  print("DEBUG: Form validation passed");
                  print(
                      "DEBUG: Form values: ${formKey.currentState?.value.toString()}");

                  var request = Map.from(formKey.currentState?.value ?? {});
                  print("DEBUG: Request before adding UserId: $request");

                  // ✅ Dodajte UserId
                  request['UserId'] = 1; // Default user ID
                  print("DEBUG: Request after adding UserId: $request");

                  print("DEBUG: Calling komentariProizvodProvider.insert...");
                  try {
                    widget.komentariProizvod =
                        await komentariProizvodProvider.insert(request);
                    print(
                        "DEBUG: Insert successful! Result: ${widget.komentariProizvod}");
                    await initFormData();
                    print("DEBUG: Form data refreshed");
                  } catch (e) {
                    print("DEBUG: Insert failed with error: $e");
                    print("DEBUG: Error type: ${e.runtimeType}");
                    print("DEBUG: Error stack trace: ${StackTrace.current}");
                  }
                } else {
                  print("DEBUG: Form validation failed");
                }
              },
              child: Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
