import 'package:mothea3_app/modules/auth/domain/entity/register_response.dart';
import 'package:mothea3_app/modules/auth/data/model/user_model.dart';

class RegisterResponseModel extends RegisterResponse {
  const RegisterResponseModel({
    required UserModel super.user,
    required super.accessToken,
  });

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(
      accessToken: json["token"],
      user: UserModel.fromJson(json["user"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "token": accessToken,
    "user": (user as UserModel).toJson(),
  };
}
