// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../models/carts_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CartModelImpl _$$CartModelImplFromJson(Map<String, dynamic> json) =>
    _$CartModelImpl(
      cartId: (json['cart_id'] as num?)?.toInt(),
      userId: (json['user_id'] as num?)?.toInt(),
      itemId: (json['item_id'] as num?)?.toInt(),
      quantity: (json['quantity'] as num?)?.toInt(),
      itemName: json['item_name'] as String?,
      itemPrice: json['item_price'] as String?,
      itemImage: json['item_image'] as String?,
    );

Map<String, dynamic> _$$CartModelImplToJson(_$CartModelImpl instance) =>
    <String, dynamic>{
      if (instance.cartId case final value?) 'cart_id': value,
      if (instance.userId case final value?) 'user_id': value,
      if (instance.itemId case final value?) 'item_id': value,
      if (instance.quantity case final value?) 'quantity': value,
      if (instance.itemName case final value?) 'item_name': value,
      if (instance.itemPrice case final value?) 'item_price': value,
      if (instance.itemImage case final value?) 'item_image': value,
    };
