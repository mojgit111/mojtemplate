import 'package:ecommerce_desktop/model/product.dart';
import 'package:ecommerce_desktop/model/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ispit.g.dart';

@JsonSerializable()
class Ispit {
  final int id;
  final int userId;
  final User? user;
  final int productId;
  final Product? product;
  final double minimalanIznosNarudzbe;
  final int brojNarudzbe;
  final double IznosNarudzbe;

  Ispit({
    this.id = 0,
    this.userId = 0,
    this.user,
    this.productId=0,
    this.product,
    this.minimalanIznosNarudzbe=0,
    this.brojNarudzbe=0,
    this.IznosNarudzbe=0,
  });

  factory Ispit.fromJson(Map<String, dynamic> json) =>
      _$IspitFromJson(json);

  Map<String, dynamic> toJson() => _$IspitToJson(this);

  
}
