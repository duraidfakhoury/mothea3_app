import 'package:equatable/equatable.dart';
import 'package:mothea3_app/core/enums/acadimic_status.dart';

class Profile extends Equatable {
  final String userName;
  final String email;
  final String number;
  final AcadimicStatus acadamicStatus;

  const Profile({
    required this.userName,
    required this.email,
    required this.number,
    required this.acadamicStatus,
  });
  
  @override
  List<Object?> get props => [userName , email , number , acadamicStatus];
  
}
