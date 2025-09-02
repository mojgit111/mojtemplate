

import 'package:ecommerce_desktop/model/product.dart';
import 'package:json_annotation/json_annotation.dart';

part 'proizvod_komentari.g.dart';


@JsonSerializable()
class ProizvodKomentari {
  final int id;
  final String komentar;
  final int productId;
  final Product? product;
  final DateTime datumKreiranjaKomentara;

  ProizvodKomentari({
    this.id = 0,
    this.komentar= '',
    this.productId = 0,
    this.product,
    required this.datumKreiranjaKomentara,
  });

  factory ProizvodKomentari.fromJson(Map<String, dynamic> json) => _$ProizvodKomentariFromJson(json);

  Map<String, dynamic> toJson() => _$ProizvodKomentariToJson(this);
}
