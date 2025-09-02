import 'dart:convert';

import 'package:ecommerce_desktop/model/product.dart';
import 'package:ecommerce_desktop/model/proizvod_komentari.dart';
import 'package:ecommerce_desktop/model/search_result.dart';
import 'package:ecommerce_desktop/providers/base_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerce_desktop/providers/auth_provider.dart';

class ProizvodKomentariProvider extends BaseProvider<ProizvodKomentari> {
  ProizvodKomentariProvider()
      : super("ProizvodiKomentari"); // ← ISPRAVI: dodaj "i" na kraju

  @override
  ProizvodKomentari fromJson(dynamic json) {
    return ProizvodKomentari.fromJson(json);
  }

  Future<List<ProizvodKomentari>> getAllComments() async {
    var _baseUrl = "http://localhost:5121";
    var url = "$_baseUrl/api/ProizvodiKomentari";

    var uri = Uri.parse(url);
    var headers = createHeaders();

    var response = await http.get(uri, headers: headers);

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);

      return (data as List).map((e) => ProizvodKomentari.fromJson(e)).toList();
    } else {
      throw new Exception("Unknown error");
    }
  }
}
