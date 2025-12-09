import 'dart:async';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mothea3_app/core/utils/base_state.dart';
import 'package:mothea3_app/modules/cultural/domain/entity/cultural_base_level.dart';
import 'package:mothea3_app/modules/cultural/domain/repository/cultural_repository.dart';
part 'cultural_base_levels_event.dart';

class CulturalBaseLevelsBloc
    extends Bloc<CulturalBaseLevelsEvent, BaseState<List<CulturalBaseLevel>>> {
  final CulturalRepository culturalRepository;

  CulturalBaseLevelsBloc(this.culturalRepository)
      : super(const BaseState<List<CulturalBaseLevel>>()) {
    on<GetBaseLevelsEvent>(_getBaseLevels, transformer: restartable());
  }

  FutureOr<void> _getBaseLevels(
      GetBaseLevelsEvent event, emit) async {
    emit(state.loading());

    final result = await culturalRepository.getBaseLevels();

    result.fold(
      (failure) => emit(state.error(failure)),
      (levels) => emit(state.success(levels)),
    );
  }
}
