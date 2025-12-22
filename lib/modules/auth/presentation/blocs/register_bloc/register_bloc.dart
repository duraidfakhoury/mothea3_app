import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mothea3_app/core/enums/auth_status.dart';
import 'package:mothea3_app/core/utils/base_state.dart';
import 'package:mothea3_app/modules/auth/domain/entity/register_response.dart';
import 'package:mothea3_app/modules/auth/domain/parameters/register_parameters.dart';
import 'package:mothea3_app/modules/auth/domain/repository/auth_repository.dart';
part 'register_event.dart';


class RegisterBloc extends Bloc<RegisterEvent , BaseState<RegisterResponse>> {
    final AuthRepository authRepository ; 
    RegisterBloc(this.authRepository) : super(const BaseState<RegisterResponse>()) {
    on<RegisterTappedEvent>(_register, transformer: restartable());
  }
    FutureOr<void> _register(RegisterTappedEvent event, emit) async {
    emit(state.loading());
    final result =
         await authRepository.register(
            RegisterParameters(
                email: event.email, 
                firstName: event.firstName,
                lastName: event.lastName,
                userName: event.userName,
                password: event.password),
          );
    result.fold((l) => emit(state.error(l)), (r) => emit(state.success(r)));
  }

}