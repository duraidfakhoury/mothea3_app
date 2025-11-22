import 'dart:async';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mothea3_app/core/utils/base_state.dart';
import 'package:mothea3_app/modules/radio/domian/entity/radio_level_lesson.dart';
import 'package:mothea3_app/modules/radio/domian/repository/radio_repository.dart';
part 'radio_level_lessons_event.dart';

class RadioLevelLessonsBloc
    extends Bloc<RadioLevelLessonsEvent, BaseState<List<RadioLevelLesson>>> {
  final RadioRepository radioRepository;

  RadioLevelLessonsBloc(this.radioRepository)
      : super(const BaseState<List<RadioLevelLesson>>()) {
    on<GetLevelLessonsEvent>(_getLevelLessons, transformer: restartable());
  }

  FutureOr<void> _getLevelLessons(
      GetLevelLessonsEvent event, emit) async {
    emit(state.loading());

    final result = await radioRepository.getlevelLessons(event.levelId);

    result.fold(
      (failure) => emit(state.error(failure)),
      (levels) => emit(state.success(levels)),
    );
  }
}
