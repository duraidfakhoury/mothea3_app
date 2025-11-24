import 'package:mothea3_app/core/enums/acadimic_status.dart';
import 'package:mothea3_app/modules/auth/domain/entity/profile.dart';

class ProfileModel extends Profile {
  const ProfileModel({
    required super.userName,
    required super.email,
    required super.number,
    required super.acadamicStatus,
  });

  static AcadimicStatus stringToStatus (String value ){
    switch (value.toLowerCase()){
      case "beginner" : 
        return AcadimicStatus.beginner;
      case "intermediate" : 
        return AcadimicStatus.intermediate;
      case "advanced" : 
        return AcadimicStatus.advanced;
      default : 
        return AcadimicStatus.beginner;
    }
  }

  static String statusToString (AcadimicStatus status){
    return status.name;
  }


  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      userName: json["user_name"],
      email: json["email"],
      number: json["number"],
      acadamicStatus: stringToStatus(json["acadamic_status"]),
    );
  }
}
