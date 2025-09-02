// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ispit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ispit _$IspitFromJson(Map<String, dynamic> json) => Ispit(
      id: (json['id'] as num?)?.toInt() ?? 0,
      userId: (json['userId'] as num?)?.toInt() ?? 0,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      productId: (json['productId'] as num?)?.toInt() ?? 0,
      product: json['product'] == null
          ? null
          : Product.fromJson(json['product'] as Map<String, dynamic>),
      minimalanIznosNarudzbe:
          (json['minimalanIznosNarudzbe'] as num?)?.toDouble() ?? 0,
      brojNarudzbe: (json['brojNarudzbe'] as num?)?.toInt() ?? 0,
      IznosNarudzbe: (json['IznosNarudzbe'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$IspitToJson(Ispit instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'user': instance.user,
      'productId': instance.productId,
      'product': instance.product,
      'minimalanIznosNarudzbe': instance.minimalanIznosNarudzbe,
      'brojNarudzbe': instance.brojNarudzbe,
      'IznosNarudzbe': instance.IznosNarudzbe,
    };
