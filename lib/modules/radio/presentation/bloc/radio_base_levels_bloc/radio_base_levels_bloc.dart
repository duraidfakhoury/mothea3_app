import 'dart:async';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mothea3_app/core/utils/base_state.dart';
import 'package:mothea3_app/modules/radio/domian/entity/radio_base_level.dart';
import 'package:mothea3_app/modules/radio/domian/repository/radio_repository.dart';
part 'radio_base_levels_event.dart';

class RadioBaseLevelsBloc
    extends Bloc<RadioBaseLevelsEvent, BaseState<List<RadioBaseLevel>>> {
  final RadioRepository radioRepository;

  RadioBaseLevelsBloc(this.radioRepository)
      : super(const BaseState<List<RadioBaseLevel>>()) {
    on<GetBaseLevelsEvent>(_getBaseLevels, transformer: restartable());
  }

  FutureOr<void> _getBaseLevels(
      GetBaseLevelsEvent event, emit) async {
    emit(state.loading());

    final result = await radioRepository.getBaseLevels();

    result.fold(
      (failure) => emit(state.error(failure)),
      (levels) => emit(state.success(levels)),
    );
  }
}
