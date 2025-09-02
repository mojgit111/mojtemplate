// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'proizvod_komentari.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProizvodKomentari _$ProizvodKomentariFromJson(Map<String, dynamic> json) =>
    ProizvodKomentari(
      id: (json['id'] as num?)?.toInt() ?? 0,
      productId: (json['productId'] as num?)?.toInt() ?? 0,
      product: json['product'] == null
          ? null
          : Product.fromJson(json['product'] as Map<String, dynamic>),
      datumKreiranjaKomentara:
          DateTime.parse(json['datumKreiranjaKomentara'] as String),
      komentar: json['komentar'] as String? ?? '',
      userId: (json['userId'] as num?)?.toInt() ?? 0,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      userFirstName: json['userFirstName'] as String?,
      userLastName: json['userLastName'] as String?,
      wordCount: (json['wordCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ProizvodKomentariToJson(ProizvodKomentari instance) =>
    <String, dynamic>{
      'id': instance.id,
      'productId': instance.productId,
      'product': instance.product,
      'datumKreiranjaKomentara':
          instance.datumKreiranjaKomentara.toIso8601String(),
      'komentar': instance.komentar,
      'userId': instance.userId,
      'user': instance.user,
      'userFirstName': instance.userFirstName,
      'userLastName': instance.userLastName,
      'wordCount': instance.wordCount,
    };
