import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String firstName;
  final String lastName;
  final String userName;
  final String email;
  final String createdAt; 
  final String updatedAt; 


  const User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.createdAt,
    required this.updatedAt,

  });

  @override
  List<Object?> get props => [
    firstName,
    lastName,
    userName,
    email,
    id,
    createdAt,
    updatedAt
  ];
}
