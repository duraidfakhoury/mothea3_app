import 'package:dartz/dartz.dart';
import 'package:mothea3_app/core/enums/auth_status.dart';
import 'package:mothea3_app/core/network/app_errors_handler.dart';
import 'package:mothea3_app/core/network/exeptions/failure.dart';
import 'package:mothea3_app/core/services/cache_service.dart';
import 'package:mothea3_app/modules/auth/data/data_source/auth_data_source.dart';
import 'package:mothea3_app/modules/auth/domain/entity/profile.dart';
import 'package:mothea3_app/modules/auth/domain/parameters/login_parameters.dart';
import 'package:mothea3_app/modules/auth/domain/parameters/register_parameters.dart';
import 'package:mothea3_app/modules/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  AuthDataSource authDataSoource;

  AuthRepositoryImpl(this.authDataSoource);

  @override
  Future<AuthStatus> checkAuthentication() async {
    if (CacheService().hasToken) {
      return AuthStatus.authenticated;
    } else {
      return AuthStatus.unAuthenticated;
    }
  }

  @override
  Future<Either<Failure, AuthStatus>> login(LoginParameters parameters) {
    return AppErrorsHandler().defaultHandleEither(
      () => authDataSoource.login(parameters),
    );
  }

  @override
  Future<Either<Failure, AuthStatus>> register(RegisterParameters parameters) {
    return AppErrorsHandler().defaultHandleEither(
      () => authDataSoource.register(parameters),
    );
  }

  @override
  Future<Either<Failure, Profile>> getUser() {
    return AppErrorsHandler().defaultHandleEither(
      () => authDataSoource.getUser(),
    );
  }
}
