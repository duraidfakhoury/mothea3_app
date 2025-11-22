import 'package:equatable/equatable.dart';

class Profile extends Equatable {
  final String userName;
  final String email;
  final String number;
  final String acadamicStatus;

  const Profile({
    required this.userName,
    required this.email,
    required this.number,
    required this.acadamicStatus,
  });
  
  @override
  // TODO: implement props
  List<Object?> get props => [userName , email , number , acadamicStatus];

  
}
