import 'package:freezed_annotation/freezed_annotation.dart';
part '../gen/order_model.freezed.dart';
part '../gen/order_model.g.dart';

@freezed
class OrderModel with _$OrderModel {
  factory OrderModel({
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'total_amount', fromJson: _stringToDouble)
    double? totalAmount,
    @JsonKey(name: 'address') String? address,
    @JsonKey(name: 'status') String? status,
    @JsonKey(name: 'items') List<OrderItem>? items,
    @JsonKey(name: 'created_at') String? createdAt,
  }) = _OrderModel;

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);
}

@freezed
class OrderItem with _$OrderItem {
  factory OrderItem({
    @JsonKey(name: 'item_id') int? itemId,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'quantity') int? quantity,
    @JsonKey(name: 'price', fromJson: _stringToDouble) double? price,
  }) = _OrderItem;

  factory OrderItem.fromJson(Map<String, dynamic> json) =>
      _$OrderItemFromJson(json);
}

// Helper function to convert String to double
double? _stringToDouble(dynamic value) {
  if (value == null) return null;
  if (value is double) return value;
  if (value is String) {
    return double.tryParse(value);
  }
  throw ArgumentError('Cannot convert $value to double');
}
