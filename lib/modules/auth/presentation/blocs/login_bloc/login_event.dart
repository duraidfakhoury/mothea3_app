part of 'login_bloc.dart';

// import 'package:equatable/equatable.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
} 

class LoginTapped extends LoginEvent{
  final String email;
  final String password; 

  const LoginTapped({
    required this.email,
    required this.password
  });

}