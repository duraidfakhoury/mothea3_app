import 'dart:async';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mothea3_app/core/utils/base_state.dart';
import 'package:mothea3_app/modules/television/domain/entitiy/television_level_lesson.dart';
import 'package:mothea3_app/modules/television/domain/repository/television_repository.dart';
part 'television_level_lessons_event.dart';

class TelevisionLevelLessonsBloc
    extends Bloc<TelevisionLevelLessonsEvent, BaseState<List<TelevisionLevelLesson>>> {
  final TelevisionRepository televisionRepository;

  TelevisionLevelLessonsBloc(this.televisionRepository)
      : super(const BaseState<List<TelevisionLevelLesson>>()) {
    on<GetLevelLessonsEvent>(_getLevelLessons, transformer: restartable());
  }

  FutureOr<void> _getLevelLessons(
      GetLevelLessonsEvent event, emit) async {
    emit(state.loading());

    final result = await televisionRepository.getlevelLessons(event.levelId);

    result.fold(
      (failure) => emit(state.error(failure)),
      (levels) => emit(state.success(levels)),
    );
  }
}
