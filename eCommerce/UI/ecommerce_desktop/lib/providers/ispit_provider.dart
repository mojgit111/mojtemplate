import 'dart:convert';

import 'package:ecommerce_desktop/model/ispit.dart';
import 'package:ecommerce_desktop/model/product.dart';
import 'package:ecommerce_desktop/model/search_result.dart';
import 'package:ecommerce_desktop/providers/base_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerce_desktop/providers/auth_provider.dart';

class IspitProvider extends BaseProvider<Ispit> {
  IspitProvider() : super("product");

  @override
  Ispit fromJson(dynamic json) {
    return Ispit.fromJson(json);
  }
}