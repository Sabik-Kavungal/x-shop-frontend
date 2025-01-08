// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../models/order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrderModelImpl _$$OrderModelImplFromJson(Map<String, dynamic> json) =>
    _$OrderModelImpl(
      id: (json['id'] as num?)?.toInt(),
      totalAmount: _stringToDouble(json['total_amount']),
      address: json['address'] as String?,
      status: json['status'] as String?,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$$OrderModelImplToJson(_$OrderModelImpl instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.totalAmount case final value?) 'total_amount': value,
      if (instance.address case final value?) 'address': value,
      if (instance.status case final value?) 'status': value,
      if (instance.items?.map((e) => e.toJson()).toList() case final value?)
        'items': value,
      if (instance.createdAt case final value?) 'created_at': value,
    };

_$OrderItemImpl _$$OrderItemImplFromJson(Map<String, dynamic> json) =>
    _$OrderItemImpl(
      itemId: (json['item_id'] as num?)?.toInt(),
      name: json['name'] as String?,
      quantity: (json['quantity'] as num?)?.toInt(),
      price: _stringToDouble(json['price']),
    );

Map<String, dynamic> _$$OrderItemImplToJson(_$OrderItemImpl instance) =>
    <String, dynamic>{
      if (instance.itemId case final value?) 'item_id': value,
      if (instance.name case final value?) 'name': value,
      if (instance.quantity case final value?) 'quantity': value,
      if (instance.price case final value?) 'price': value,
    };
