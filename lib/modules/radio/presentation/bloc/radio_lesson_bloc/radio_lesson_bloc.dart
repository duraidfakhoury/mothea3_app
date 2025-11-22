import 'dart:async';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mothea3_app/core/utils/base_state.dart';
import 'package:mothea3_app/modules/radio/domian/entity/radio_lesson.dart';
import 'package:mothea3_app/modules/radio/domian/repository/radio_repository.dart';
part 'radio_lesson_event.dart';

class RadioLessonBloc
    extends Bloc<RadioLessonEvent, BaseState<RadioLesson>> {
  final RadioRepository radioRepository;

  RadioLessonBloc(this.radioRepository)
      : super(const BaseState<RadioLesson>()) {
    on<GetRadioLessonEvent>(_getBaseLevels, transformer: restartable());
  }

  FutureOr<void> _getBaseLevels(
      GetRadioLessonEvent event, emit) async {
    emit(state.loading());

    final result = await radioRepository.getRadioLesson(event.levelId,event.lessonId);

    result.fold(
      (failure) => emit(state.error(failure)),
      (lesson) => emit(state.success(lesson)),
    );
  }
}
