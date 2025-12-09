import 'package:equatable/equatable.dart';
import 'dart:async';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mothea3_app/core/utils/base_state.dart';
import 'package:mothea3_app/modules/cultural/domain/entity/cultural_lesson.dart';
import 'package:mothea3_app/modules/cultural/domain/entity/question.dart';
import 'package:mothea3_app/modules/cultural/domain/repository/cultural_repository.dart';
part 'cultural_lesson_event.dart';
part 'cultural_lesson_state.dart';

class CulturalLessonBloc
    extends Bloc<CulturalLessonEvent, CulturalLessonState> {
  final CulturalRepository culturalRepository;

  CulturalLessonBloc(this.culturalRepository)
    : super(const CulturalLessonState()) {
    on<GetLessonEvent>(_getLesson, transformer: restartable());
    on<GetLessonQuestionsEvent>(
      _getLessonQuestions,
      transformer: restartable(),
    );
  }

  // ===============================
  // LOAD LESSON
  // ===============================
  FutureOr<void> _getLesson(
    GetLessonEvent event,
    Emitter<CulturalLessonState> emit,
  ) async {
    emit(state.copyWith(lessonState: state.lessonState.loading()));

    final result = await culturalRepository.getLesson(event.lessonId);

    result.fold(
      (failure) =>
          emit(state.copyWith(lessonState: state.lessonState.error(failure))),
      (lesson) =>
          emit(state.copyWith(lessonState: state.lessonState.success(lesson))),
    );
  }

  // ===============================
  // LOAD LESSON QUESTIONS
  // ===============================
  FutureOr<void> _getLessonQuestions(
    GetLessonQuestionsEvent event,
    Emitter<CulturalLessonState> emit,
  ) async {
    emit(state.copyWith(questionsState: state.questionsState.loading()));

    final result = await culturalRepository.getLessonQuestions(event.lessonId);

    result.fold(
      (failure) => emit(
        state.copyWith(questionsState: state.questionsState.error(failure)),
      ),
      (questions) => emit(
        state.copyWith(questionsState: state.questionsState.success(questions)),
      ),
    );
  }
}
