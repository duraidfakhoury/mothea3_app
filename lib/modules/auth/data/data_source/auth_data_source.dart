import 'package:mothea3_app/core/enums/auth_status.dart';
import 'package:mothea3_app/modules/auth/data/model/profile_model.dart';
import 'package:mothea3_app/modules/auth/domain/parameters/login_parameters.dart';
import 'package:mothea3_app/modules/auth/domain/parameters/register_parameters.dart';

abstract class AuthDataSource {
  Future<AuthStatus> login(LoginParameters parameters);
  Future<AuthStatus> register(RegisterParameters parameters);
  Future<ProfileModel> getUser();
}
