
import 'package:mothea3_app/modules/auth/domain/entity/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.email,
    required super.firstName,
    required super.lastName,
    required super.userName,
    required super.createdAt,
    required super.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      email: json["email"] as String,
      firstName: json["first_name"] as String,
      lastName: json["last_name"] as String,
      userName: json["user_name"] as String,
      createdAt: json["created_at"] as String,
      updatedAt: json["updated_at"] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_name": userName,
    "email": email,
    "first_name": firstName,
    "last_name": lastName,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
