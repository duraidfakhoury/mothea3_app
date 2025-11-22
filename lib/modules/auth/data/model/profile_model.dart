import 'package:mothea3_app/modules/auth/domain/entity/profile.dart';

class ProfileModel extends Profile {
  const ProfileModel({
    required super.userName,
    required super.email,
    required super.number,
    required super.acadamicStatus,
  });
  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      userName: json["user_name"],
      email: json["email"],
      number: json["number"],
      acadamicStatus: json["acadamic_status"],
    );
  }
}
