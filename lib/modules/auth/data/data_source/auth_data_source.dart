import 'package:mothea3_app/modules/auth/data/model/profile_model.dart';
import 'package:mothea3_app/modules/auth/data/model/login_response_model.dart';
import 'package:mothea3_app/modules/auth/data/model/register_response_model.dart';
import 'package:mothea3_app/modules/auth/domain/parameters/login_parameters.dart';
import 'package:mothea3_app/modules/auth/domain/parameters/register_parameters.dart';

abstract class AuthDataSource {
  Future<LoginResponseModel> login(LoginParameters parameters);
  Future<RegisterResponseModel> register(RegisterParameters parameters);
  Future<ProfileModel> getUser();
}
