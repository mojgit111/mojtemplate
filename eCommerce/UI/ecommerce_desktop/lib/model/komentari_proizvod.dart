import 'package:ecommerce_desktop/model/product.dart';
import 'package:ecommerce_desktop/model/user.dart';
import 'package:json_annotation/json_annotation.dart';
part 'komentari_proizvod.g.dart';
@JsonSerializable()
class KomentariProizvod {
  final int id;
  final int productId;
  final Product? product;
  final DateTime datumKreiranjaKomentara;
  final String komentarKorisnika;
  final int? userId;
  final User? user;

  KomentariProizvod({
    this.id = 0,
    this.productId = 0,
    this.product,
    required this.datumKreiranjaKomentara,
    this.komentarKorisnika ='',
    this.userId=0,
    this.user,
  });

  factory KomentariProizvod.fromJson(Map<String, dynamic> json) => _$KomentariProizvodFromJson(json);

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
