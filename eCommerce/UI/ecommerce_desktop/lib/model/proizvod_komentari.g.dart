// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'proizvod_komentari.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProizvodKomentari _$ProizvodKomentariFromJson(Map<String, dynamic> json) =>
    ProizvodKomentari(
      id: (json['id'] as num?)?.toInt() ?? 0,
      komentar: json['komentar'] as String? ?? '',
      productId: (json['productId'] as num?)?.toInt() ?? 0,
      product: json['product'] == null
          ? null
          : Product.fromJson(json['product'] as Map<String, dynamic>),
      datumKreiranjaKomentara:
          DateTime.parse(json['datumKreiranjaKomentara'] as String),
    );

Map<String, dynamic> _$ProizvodKomentariToJson(ProizvodKomentari instance) =>
    <String, dynamic>{
      'id': instance.id,
      'komentar': instance.komentar,
      'productId': instance.productId,
      'product': instance.product,
      'datumKreiranjaKomentara':
          instance.datumKreiranjaKomentara.toIso8601String(),
    };
