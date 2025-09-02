import 'package:json_annotation/json_annotation.dart';
import 'product.dart';
import 'user.dart';

part 'proizvod_komentari.g.dart';

@JsonSerializable()
class ProizvodKomentari {
  final int id;
  final int productId;
  final Product? product;
  final DateTime datumKreiranjaKomentara;
  final String komentar;
  final int userId;
  final User? user;
  final String? userFirstName;
  final String? userLastName;
  final int? wordCount;

  ProizvodKomentari({
    this.id = 0,
    this.productId = 0,
    this.product,
    required this.datumKreiranjaKomentara,
    this.komentar = '',
    this.userId = 0,
    this.user,
    this.userFirstName,
    this.userLastName,
    this.wordCount,
  });

  factory ProizvodKomentari.fromJson(Map<String, dynamic> json) =>
      _$ProizvodKomentariFromJson(json);

  Map<String, dynamic> toJson() => _$ProizvodKomentariToJson(this);
}
