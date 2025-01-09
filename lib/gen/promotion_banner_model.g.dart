// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../models/promotion_banner_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PromotionBanneModelImpl _$$PromotionBanneModelImplFromJson(
        Map<String, dynamic> json) =>
    _$PromotionBanneModelImpl(
      title: json['title'] as String?,
      description: json['description'] as String?,
      imageUrl: json['image_url'] as String?,
      startDate: json['start_date'] as String?,
      endDate: json['end_date'] as String?,
    );

Map<String, dynamic> _$$PromotionBanneModelImplToJson(
        _$PromotionBanneModelImpl instance) =>
    <String, dynamic>{
      if (instance.title case final value?) 'title': value,
      if (instance.description case final value?) 'description': value,
      if (instance.imageUrl case final value?) 'image_url': value,
      if (instance.startDate case final value?) 'start_date': value,
      if (instance.endDate case final value?) 'end_date': value,
    };
