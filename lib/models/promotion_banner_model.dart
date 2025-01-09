import 'package:freezed_annotation/freezed_annotation.dart';
part '../gen/promotion_banner_model.freezed.dart';
part '../gen/promotion_banner_model.g.dart';

@freezed
class PromotionBanneModel with _$PromotionBanneModel {
  const factory PromotionBanneModel({
    @JsonKey(name: 'title') String? title,
    @JsonKey(name: 'description') String? description,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'start_date') String? startDate,
    @JsonKey(name: 'end_date') String? endDate,
  }) = _PromotionBanneModel;

  factory PromotionBanneModel.fromJson(Map<String, dynamic> json) =>
      _$PromotionBanneModelFromJson(json);
}
