import 'package:freezed_annotation/freezed_annotation.dart';
part '../gen/carts_model.freezed.dart';
part '../gen/carts_model.g.dart';


@freezed
class CartModel with _$CartModel {
  const factory CartModel({
    @JsonKey(name: 'cart_id') int? cartId,
    @JsonKey(name: 'user_id') int? userId,
    @JsonKey(name: 'item_id') int? itemId,
    int? quantity,
    @JsonKey(name: 'item_name') String? itemName,
    @JsonKey(name: 'item_price') String? itemPrice,
    @JsonKey(name: 'item_image') String? itemImage,
  }) = _CartModel;

  factory CartModel.fromJson(Map<String, dynamic> json) => _$CartModelFromJson(json);
}