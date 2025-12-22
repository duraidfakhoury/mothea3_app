import 'dart:async';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mothea3_app/core/utils/base_state.dart';
import 'package:mothea3_app/modules/auth/domain/entity/login_response.dart';
import 'package:mothea3_app/modules/auth/domain/parameters/login_parameters.dart';
import 'package:mothea3_app/modules/auth/domain/repository/auth_repository.dart';

part 'login_event.dart';

class LoginBloc extends Bloc<LoginEvent, BaseState<LoginResponse>> {
  final AuthRepository authRepository;
  LoginBloc(this.authRepository) : super(const BaseState<LoginResponse>()) {
    on<LoginTapped>(_login, transformer: restartable());
  }
  FutureOr<void> _login(LoginTapped event, emit) async {
    emit(state.loading());
    final result = await authRepository.login(
      LoginParameters(email: event.email, password: event.password),
    );
    result.fold((l) => emit(state.error(l)), (r) => emit(state.success(r)));
  }
}
