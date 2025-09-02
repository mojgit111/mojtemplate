// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'komentari_proizvod.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KomentariProizvod _$KomentariProizvodFromJson(Map<String, dynamic> json) =>
    KomentariProizvod(
      id: (json['id'] as num?)?.toInt() ?? 0,
      productId: (json['productId'] as num?)?.toInt() ?? 0,
      product: json['product'] == null
          ? null
          : Product.fromJson(json['product'] as Map<String, dynamic>),
      datumKreiranjaKomentara:
          DateTime.parse(json['datumKreiranjaKomentara'] as String),
      komentarKorisnika: json['komentarKorisnika'] as String? ?? '',
      userId: (json['userId'] as num?)?.toInt() ?? 0,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$KomentariProizvodToJson(KomentariProizvod instance) =>
    <String, dynamic>{
      'id': instance.id,
      'productId': instance.productId,
      'product': instance.product,
      'datumKreiranjaKomentara':
          instance.datumKreiranjaKomentara.toIso8601String(),
      'komentarKorisnika': instance.komentarKorisnika,
      'userId': instance.userId,
      'user': instance.user,
    };
