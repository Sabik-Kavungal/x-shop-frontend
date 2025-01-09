// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../models/deal_of_day_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DealOfDayModelImpl _$$DealOfDayModelImplFromJson(Map<String, dynamic> json) =>
    _$DealOfDayModelImpl(
      id: (json['id'] as num?)?.toInt(),
      itemId: (json['item_id'] as num?)?.toInt(),
      productName: json['product_name'] as String?,
      price: json['price'] as String?,
      discountPercentage: json['discount_percentage'] as String?,
      startDate: json['start_date'] as String?,
      endDate: json['end_date'] as String?,
    );

Map<String, dynamic> _$$DealOfDayModelImplToJson(
        _$DealOfDayModelImpl instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.itemId case final value?) 'item_id': value,
      if (instance.productName case final value?) 'product_name': value,
      if (instance.price case final value?) 'price': value,
      if (instance.discountPercentage case final value?)
        'discount_percentage': value,
      if (instance.startDate case final value?) 'start_date': value,
      if (instance.endDate case final value?) 'end_date': value,
    };
