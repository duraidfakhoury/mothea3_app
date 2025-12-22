import 'package:equatable/equatable.dart';
import 'package:mothea3_app/modules/auth/domain/entity/user.dart';

class RegisterResponse extends Equatable {
  final String accessToken;
  final User user;

  const RegisterResponse({required this.accessToken, required this.user});
  @override
  List<Object?> get props => [accessToken , user];
}
