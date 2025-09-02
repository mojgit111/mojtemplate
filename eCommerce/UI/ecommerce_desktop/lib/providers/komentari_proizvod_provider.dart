import 'dart:convert';
import 'package:ecommerce_desktop/model/komentari_proizvod.dart';
import 'package:ecommerce_desktop/model/product.dart';
import 'package:ecommerce_desktop/model/search_result.dart';
import 'package:ecommerce_desktop/providers/base_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerce_desktop/providers/auth_provider.dart';

class KomentariProizvodProvider extends BaseProvider<KomentariProizvod> {
  KomentariProizvodProvider() : super("komentariProizvodi");

  @override
  KomentariProizvod fromJson(dynamic json) {
    return KomentariProizvod.fromJson(json);
  }
}