// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spaseni.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Spaseni _$SpaseniFromJson(Map<String, dynamic> json) => Spaseni(
      id: (json['id'] as num?)?.toInt() ?? 0,
      productId: (json['productId'] as num?)?.toInt() ?? 0,
      product: json['product'] == null
          ? null
          : Product.fromJson(json['product'] as Map<String, dynamic>),
      userId: (json['userId'] as num?)?.toInt() ?? 0,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      datumSpasavanja: DateTime.parse(json['datumSpasavanja'] as String),
    );

Map<String, dynamic> _$SpaseniToJson(Spaseni instance) => <String, dynamic>{
      'id': instance.id,
      'productId': instance.productId,
      'product': instance.product,
      'userId': instance.userId,
      'user': instance.user,
      'datumSpasavanja': instance.datumSpasavanja.toIso8601String(),
    };
