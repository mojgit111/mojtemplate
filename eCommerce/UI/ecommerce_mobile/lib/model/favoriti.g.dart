// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favoriti.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Favoriti _$FavoritiFromJson(Map<String, dynamic> json) => Favoriti(
      id: (json['id'] as num?)?.toInt() ?? 0,
      productId: (json['productId'] as num?)?.toInt() ?? 0,
      userId: (json['userId'] as num?)?.toInt() ?? 0,
      datumOznacavanja: DateTime.parse(json['datumOznacavanja'] as String),
      product: json['product'] == null
          ? null
          : Product.fromJson(json['product'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FavoritiToJson(Favoriti instance) => <String, dynamic>{
      'id': instance.id,
      'productId': instance.productId,
      'userId': instance.userId,
      'datumOznacavanja': instance.datumOznacavanja.toIso8601String(),
      'product': instance.product,
    };
