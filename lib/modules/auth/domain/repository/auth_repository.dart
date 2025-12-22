import 'package:dartz/dartz.dart';
import 'package:mothea3_app/core/enums/auth_status.dart';
import 'package:mothea3_app/core/network/exeptions/failure.dart';
import 'package:mothea3_app/modules/auth/domain/entity/login_response.dart';
import 'package:mothea3_app/modules/auth/domain/entity/profile.dart';
import 'package:mothea3_app/modules/auth/domain/entity/register_response.dart';
import 'package:mothea3_app/modules/auth/domain/parameters/login_parameters.dart';
import 'package:mothea3_app/modules/auth/domain/parameters/register_parameters.dart';

abstract class AuthRepository {
  Future<AuthStatus> checkAuthentication();
  Future<Either<Failure, LoginResponse>> login(LoginParameters parameters);
  Future<Either<Failure, RegisterResponse>> register(
    RegisterParameters parameters,
  );
  Future<Either<Failure, Profile>> getUser();
}
