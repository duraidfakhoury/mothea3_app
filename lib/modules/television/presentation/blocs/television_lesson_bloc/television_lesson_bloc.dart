import 'dart:async';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mothea3_app/core/utils/base_state.dart';
import 'package:mothea3_app/modules/television/domain/entitiy/television_lesson.dart';
import 'package:mothea3_app/modules/television/domain/repository/television_repository.dart';
part 'television_lesson_event.dart';

class TelevisionLessonBloc
    extends Bloc<TelevisionLessonEvent, BaseState<TelevisionLesson>> {
  final TelevisionRepository televisionRepository;

  TelevisionLessonBloc(this.televisionRepository)
      : super(const BaseState<TelevisionLesson>()) {
    on<GetTelevisionLessonEvent>(_getBaseLevels, transformer: restartable());
  }

  FutureOr<void> _getBaseLevels(
      GetTelevisionLessonEvent event, emit) async {
    emit(state.loading());

    final result = await televisionRepository.getTelevisionLesson(event.levelId,event.lessonId);

    result.fold(
      (failure) => emit(state.error(failure)),
      (lesson) => emit(state.success(lesson)),
    );
  }
}
