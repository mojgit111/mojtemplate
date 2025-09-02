import 'dart:convert';
import 'dart:io';
import 'package:ecommerce_mobile/layouts/master_screen.dart';
import 'package:ecommerce_mobile/model/product.dart';
import 'package:ecommerce_mobile/model/proizvod_komentari.dart';
import 'package:ecommerce_mobile/model/search_result.dart';
import 'package:ecommerce_mobile/providers/product_provider.dart';
import 'package:ecommerce_mobile/providers/proizvodi_komentari_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:file_picker/file_picker.dart';

class ProduktKomentariScreen extends StatefulWidget {
  Product? product;
  ProduktKomentariScreen({super.key, this.product});

  @override
  State<ProduktKomentariScreen> createState() => _ProduktKomentariScreenState();
}

class _ProduktKomentariScreenState extends State<ProduktKomentariScreen> {
  final formKey = GlobalKey<FormBuilderState>();

  Map<String, dynamic> _initalValue = {};

  late ProductProvider productProvider;
  late ProizvodiKomentariProvider proizvodiKomentariProvider;
  List<ProizvodKomentari>? komentari;
  SearchResult<Product>? products;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initalValue = {
      "productId": null,
      "komentar": "",
      "fromDate": null,
      "toDate": null,
    };
    print("widget.product");
    print(_initalValue);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    productProvider = Provider.of<ProductProvider>(context, listen: false);
    proizvodiKomentariProvider =
        Provider.of<ProizvodiKomentariProvider>(context, listen: false);
    initFormData();
  }

  initFormData() async {
    products = await productProvider.get();
    print("DEBUG: Učitano ${products?.items?.length ?? 0} proizvoda");
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "Proizvod Komentari",
      child: Column(
        children: [
          _buildForm(),
          _buildCommentList(),
        ],
      ),
    );
  }

  File? _image;
  String? _base64Image;

  Widget _buildForm() {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    return FormBuilder(
        key: formKey,
        initialValue: _initalValue,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              FormBuilderDropdown(
                  name: "productId",
                  decoration: InputDecoration(labelText: "Proizvod"),
                  items: products?.items
                          ?.map((e) => DropdownMenuItem(
                              value: e.id, child: Text(e.name)))
                          .toList() ??
                      []),
              FormBuilderTextField(
                name: "komentar",
                decoration: InputDecoration(labelText: "Komentar"),
              ),
              Row(
                children: [
                  Expanded(
                      child: FormBuilderDateTimePicker(
                    name: "fromDate",
                    decoration: InputDecoration(labelText: "Od datuma"),
                    inputType: InputType.date,
                  )),
                  Expanded(
                      child: FormBuilderDateTimePicker(
                    name: "toDate",
                    decoration: InputDecoration(labelText: "Do datuma"),
                    inputType: InputType.date,
                  ))
                ],
              ),
              SizedBox(height: 16),
              ElevatedButton(
                  onPressed: () async {
                    formKey.currentState?.saveAndValidate();
                    if (formKey.currentState?.validate() ?? false) {
                      var request = Map.from(formKey.currentState?.value ?? {});
                      print("DEBUG: Request = $request");
                      var filter = {
                        "productId": request["productId"],
                        "fromDate": request["fromDate"]?.toIso8601String(),
                        "toDate": request["toDate"]?.toIso8601String(),
                      };

                      var komentari = await proizvodiKomentariProvider
                          .getByProductaAndDateRange(
                              request["productId"],
                              request["fromDate"] ??
                                  DateTime(2020, 1, 1), // Minimalni datum
                              request["toDate"] ??
                                  DateTime(2030, 12, 31)); // Maksimalni datum
                      print(
                          "DEBUG: Dobijeno ${komentari?.length ?? 0} komentara");
                      print(
                          "DEBUG: Prvi komentar - userFirstName: ${komentari?.firstOrNull?.userFirstName}");
                      print(
                          "DEBUG: Prvi komentar - userLastName: ${komentari?.firstOrNull?.userLastName}");
                      print(
                          "DEBUG: Prvi komentar - wordCount: ${komentari?.firstOrNull?.wordCount}");

                      setState(() {
                        this.komentari = komentari;
                      });
                    }
                  },
                  child: Text("Pretrazi")),
            ],
          ),
        ));
  }

  Widget _buildCommentList() {
    return Expanded(
        child: Container(
            width: double.infinity,
            child: SingleChildScrollView(
                child: Container(
              height: 500,
              child: ListView(
                children: _buildCommentCardList(),
              ),
            )))); // Placeholder za sada
  }

  List<Widget> _buildCommentCardList() {
    if (komentari == null || komentari?.length == 0) {
      return [Text("Nema komentara")];
    }

    List<Widget> list = komentari!
        .map((x) => Container(
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.all(4),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    x.komentar,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text("Proizvod: ${x.product?.name ?? 'N/A'}"),
                  Text(
                      "Datum: ${x.datumKreiranjaKomentara.toString().substring(0, 10)}"),
                  Text(
                      "Korisnik: ${x.userFirstName ?? ''} ${x.userLastName ?? ''}"),
                  Text("Broj riječi: ${x.wordCount ?? 0}"),
                ],
              ),
            ))
        .cast<Widget>()
        .toList();

    return list;
  }
}
