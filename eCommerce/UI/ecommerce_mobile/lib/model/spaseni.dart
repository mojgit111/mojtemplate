import 'package:ecommerce_mobile/model/product.dart';
import 'package:ecommerce_mobile/model/user.dart';
import 'package:json_annotation/json_annotation.dart';
import 'asset.dart';

part 'spaseni.g.dart';
@JsonSerializable()
class Spaseni {
  final int id;
  final int productId;
  final Product? product;
  final int userId;
  final User? user;
  final DateTime datumSpasavanja;

  Spaseni({
    this.id = 0,
    this.productId =0,
    this.product,
    this.userId = 0,
    this.user,
    required this.datumSpasavanja,
  });

  factory Spaseni.fromJson(Map<String, dynamic> json) => _$SpaseniFromJson(json);

  Map<String, dynamic> toJson() => _$SpaseniToJson(this);

  // // Factory constructor for creating Product from JSON
  // factory Product.fromJson(Map<String, dynamic> json) {
  //   return Product(
  //     id: json['id'] ?? 0,
  //     name: json['name'] ?? '',
  //     code: json['code'] ?? '',
  //     productState: json['productState'] ?? 'ActiveProductState',
  //   );
  // }

  // // Method to convert Product to JSON
  // Map<String, dynamic> toJson() {
  //   return {
  //     'id': id,
  //     'name': name,
  //     'code': code,
  //     'productState': productState,
  //   };
  // }

  // @override
  // String toString() {
  //   return 'Product{id: $id, name: $name, code: $code, productState: $productState}';
  // }
}
