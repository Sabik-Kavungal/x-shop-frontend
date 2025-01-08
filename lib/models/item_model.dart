import 'package:freezed_annotation/freezed_annotation.dart';
part '../gen/item_model.freezed.dart';
part '../gen/item_model.g.dart';


@freezed
class ItemModel with _$ItemModel {
  const factory ItemModel({
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'price') String? price,
    @JsonKey(name: 'description') String? description,
    @JsonKey(name: 'image') String? image,
    @JsonKey(name: 'category_id') int? categoryId,
    @JsonKey(name: 'category_name') String? categoryName,
  }) = _ItemModel;

  factory ItemModel.fromJson(Map<String, dynamic> json) => _$ItemModelFromJson(json);
}