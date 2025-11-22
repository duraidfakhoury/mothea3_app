import 'dart:async';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mothea3_app/core/utils/base_state.dart';
import 'package:mothea3_app/modules/television/domain/entitiy/television_base_level.dart';
import 'package:mothea3_app/modules/television/domain/repository/television_repository.dart';
part 'television_base_levels_event.dart';

class TelevisionBaseLevelsBloc
    extends Bloc<TelevisionBaseLevelsEvent, BaseState<List<TelevisionBaseLevel>>> {
  final TelevisionRepository televisionRepository;

  TelevisionBaseLevelsBloc(this.televisionRepository)
      : super(const BaseState<List<TelevisionBaseLevel>>()) {
    on<GetBaseLevelsEvent>(_getBaseLevels, transformer: restartable());
  }

  FutureOr<void> _getBaseLevels(
      GetBaseLevelsEvent event, emit) async {
    emit(state.loading());

    final result = await televisionRepository.getBaseLevels();

    result.fold(
      (failure) => emit(state.error(failure)),
      (levels) => emit(state.success(levels)),
    );
  }
}
