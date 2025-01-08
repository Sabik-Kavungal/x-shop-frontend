import 'package:freezed_annotation/freezed_annotation.dart';
part '../gen/user_model.freezed.dart';
part '../gen/user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'email') String? email,
    @JsonKey(name: 'password') String? password,
    @JsonKey(name: 'address') String? address,
    @JsonKey(name: 'phone') String? phone,
    @JsonKey(name: 'image') String? image,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
