import 'package:json_annotation/json_annotation.dart';
import 'product.dart';
part 'favoriti.g.dart';

@JsonSerializable()
class Favoriti {
  final int id;
  final int productId;
  final int userId;
  final DateTime datumOznacavanja;
  final Product? product; // navigation property

  Favoriti({
    this.id = 0,
    this.productId = 0,
    this.userId = 0,
    required this.datumOznacavanja,
    this.product,
  });

  factory Favoriti.fromJson(Map<String, dynamic> json) => _$FavoritiFromJson(json);

  Map<String, dynamic> toJson() => _$FavoritiToJson(this);
}