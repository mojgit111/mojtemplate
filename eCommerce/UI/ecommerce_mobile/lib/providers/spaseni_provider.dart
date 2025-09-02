import 'dart:convert';

import 'package:ecommerce_mobile/model/product.dart';
import 'package:ecommerce_mobile/model/search_result.dart';
import 'package:ecommerce_mobile/model/spaseni.dart';
import 'package:ecommerce_mobile/providers/base_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerce_mobile/providers/auth_provider.dart';

class SpaseniProvider extends BaseProvider<Spaseni> {
  SpaseniProvider() : super("Spaseni");

  @override
  Spaseni fromJson(dynamic json) {
    return Spaseni.fromJson(json);
  }
}