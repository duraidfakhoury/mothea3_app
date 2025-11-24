import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mothea3_app/core/utils/base_state.dart';
import 'package:mothea3_app/modules/auth/domain/entity/profile.dart';
import 'package:mothea3_app/modules/auth/domain/repository/auth_repository.dart';

part 'user_event.dart';

class UserBloc extends Bloc <UserEvent , BaseState<Profile>> {
  final AuthRepository authRepository;
  UserBloc(this.authRepository)
      : super(const BaseState<Profile>()) {
    on<GetUserEvent>(_getUser, transformer: restartable());
  }
    FutureOr<void> _getUser(
      GetUserEvent event, emit) async {
    emit(state.loading());

    final result = await authRepository.getUser();

    result.fold(
      (failure) => emit(state.error(failure)),
      (profile) => emit(state.success(profile)),
    );
  }
}