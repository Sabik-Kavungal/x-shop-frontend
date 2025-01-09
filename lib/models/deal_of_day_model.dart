import 'package:freezed_annotation/freezed_annotation.dart';
part '../gen/deal_of_day_model.freezed.dart';
part '../gen/deal_of_day_model.g.dart';

@freezed
class DealOfDayModel with _$DealOfDayModel {
  const factory DealOfDayModel({
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'item_id') int? itemId,
    @JsonKey(name: 'product_name') String? productName,
    @JsonKey(name: 'price') String? price,
    @JsonKey(name: 'discount_percentage') String? discountPercentage,
    @JsonKey(name: 'start_date') String? startDate,
    @JsonKey(name: 'end_date') String? endDate,
  }) = _DealOfDayModel;

  factory DealOfDayModel.fromJson(Map<String, dynamic> json) =>
      _$DealOfDayModelFromJson(json);
}
