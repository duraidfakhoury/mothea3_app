import 'package:mothea3_app/modules/auth/domain/entity/login_response.dart';
import 'package:mothea3_app/modules/auth/data/model/user_model.dart';

class LoginResponseModel extends LoginResponse {
  const LoginResponseModel({
    required UserModel super.user,
    required super.accessToken,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      accessToken: json["token"],
      user: UserModel.fromJson(json["user"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "token": accessToken,
    "user": (user as UserModel).toJson(),
  };
}
