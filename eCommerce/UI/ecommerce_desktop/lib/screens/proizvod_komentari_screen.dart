import 'dart:convert';
import 'dart:io';

import 'package:ecommerce_desktop/layouts/master_screen.dart';
import 'package:ecommerce_desktop/model/product.dart';
import 'package:ecommerce_desktop/model/product_type.dart';
import 'package:ecommerce_desktop/model/proizvod_komentari.dart';
import 'package:ecommerce_desktop/model/search_result.dart';
import 'package:ecommerce_desktop/model/unit_of_measure.dart';
import 'package:ecommerce_desktop/providers/product_provider.dart';
import 'package:ecommerce_desktop/providers/product_type_provider.dart';
import 'package:ecommerce_desktop/providers/proizvod_komentari_provider.dart';
import 'package:ecommerce_desktop/providers/unit_of_measure_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:file_picker/file_picker.dart';

class ProizvodKomentariScreen extends StatefulWidget {
  Product? product;
  ProizvodKomentariScreen({super.key, this.product});

  @override
  State<ProizvodKomentariScreen> createState() => _ProizvodiKomentariScreen();
}

class _ProizvodiKomentariScreen extends State<ProizvodKomentariScreen> {
  final formKey = GlobalKey<FormBuilderState>();

  Map<String, dynamic> _initalValue = {};

  late ProductProvider productProvider;
  late UnitOfMeasureProvider unitOfMeasureProvider;
  late ProductTypeProvider productTypeProvider;
  late ProizvodKomentariProvider proizvodKomentariProvider;
  SearchResult<Product>? products;
  List<ProizvodKomentari>? proizvodKomentari;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    productProvider = Provider.of<ProductProvider>(context, listen: false);
    productTypeProvider =
        Provider.of<ProductTypeProvider>(context, listen: false);
    proizvodKomentariProvider =
        Provider.of<ProizvodKomentariProvider>(context, listen: false);
    _initalValue = {
      "productTypeId": null,
      "productId": null,
      "komentar": "",
    };
    print("widget.product");
    print(_initalValue);

    initFormData();
  }

  initFormData() async {
    products = await productProvider.get();
    proizvodKomentari = await proizvodKomentariProvider.getAllComments();

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "Proizvod komentari",
      child: Column(
        children: [_buildForm(), _buildCommentList()],
      ),
    );
  }

  Widget _buildCommentList() {
    return Center(
        child: DataTable(
      columns: [
        DataColumn(label: Text('Komentar')),
        DataColumn(label: Text('Proizvod')),
        DataColumn(label: Text('Datum')),
      ],
      rows: proizvodKomentari?.map((komentar) {
            // ← DODAJ OVO
            return DataRow(
              // ← DODAJ OVO
              cells: [
                // ← DODAJ OVO
                DataCell(Text(komentar.komentar)), // ← DODAJ OVO
                DataCell(Text(komentar.product?.name ?? 'N/A')), // ← DODAJ OVO
                DataCell(Text(komentar.datumKreiranjaKomentara
                    .toString())), // ← DODAJ OVO
              ], // ← DODAJ OVO
            ); // ← DODAJ OVO
          }).toList() ??
          [], // ← DODAJ OVO
    ));
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
                        ?.map((e) =>
                            DropdownMenuItem(value: e.id, child: Text(e.name)))
                        .toList() ??
                    [],
              ),
              FormBuilderTextField(
                name: "komentar",
                decoration: InputDecoration(labelText: "Komentar"),
              ),
              ElevatedButton(
                onPressed: () async {
                  formKey.currentState?.saveAndValidate();
                  if (formKey.currentState?.validate() ?? false) {
                    var request = Map.from(formKey.currentState?.value ?? {});
                    await proizvodKomentariProvider.insert(request);
                    await initFormData();
                  }
                },
                child: Text("Save")
              ),

              // Row(
              //   children: [
              //     Expanded(
              //         child: FormBuilderField(
              //             name: "image",
              //             builder: (FormFieldState<dynamic> field) {
              //               return TextButton(
              //                 onPressed: () async {
              //                   FilePickerResult? result =
              //                       await FilePicker.platform.pickFiles();
              //                   if (result != null) {
              //                     _image = File(result.files.single.path!);
              //                     _base64Image = base64Encode(_image!.readAsBytesSync());
              //                   }
              //                 },
              //                 child: Text("Upload Image"),
              //               );
              //             }))
              //   ],
              // )
            ],
          ),
        ));
  }
}
