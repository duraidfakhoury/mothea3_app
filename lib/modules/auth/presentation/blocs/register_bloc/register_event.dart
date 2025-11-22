part of 'register_bloc.dart';

// import 'package:equatable/equatable.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object?> get props => [];
} 

class RegisterTappedEvent extends RegisterEvent{
  final String email;
  final String firstName;
  final String lastName;
  final String userName;
  final String password; 

  const RegisterTappedEvent({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.password
  });

}