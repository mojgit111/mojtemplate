import 'dart:convert';

import 'package:ecommerce_mobile/model/product.dart';
import 'package:ecommerce_mobile/model/proizvod_komentari.dart';
import 'package:ecommerce_mobile/model/search_result.dart';
import 'package:ecommerce_mobile/providers/base_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerce_mobile/providers/auth_provider.dart';

class ProizvodiKomentariProvider extends BaseProvider<ProizvodKomentari> {
  ProizvodiKomentariProvider() : super("proizvodiKomentari");

  @override
  ProizvodKomentari fromJson(dynamic json) {
    return ProizvodKomentari.fromJson(json);
  }

  Future<List<ProizvodKomentari>> getByProductaAndDateRange(
      int productId, DateTime fromDate, DateTime toDate) async {
    var _baseUrl = "http://10.0.2.2:5121/api";
    var url =
        "$_baseUrl/ProizvodiKomentari/by-product-and-date?productId=$productId&fromDate=${fromDate.toIso8601String()}&toDate=${toDate.toIso8601String()}";

    print("DEBUG: Provider URL = $url");

    var uri = Uri.parse(url);
    var headers = createHeaders();

    var response = await http.get(uri, headers: headers);

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);

      return List<ProizvodKomentari>.from(data.map((e) => fromJson(e)));
    } else {
      throw new Exception("Unknown error");
    }
  }
}
