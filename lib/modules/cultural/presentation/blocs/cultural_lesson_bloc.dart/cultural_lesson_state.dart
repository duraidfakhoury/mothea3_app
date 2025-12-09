part of 'cultural_lesson_bloc.dart';

class CulturalLessonState extends Equatable {
  final BaseState<CulturalLesson> lessonState;
  final BaseState<List<Question>> questionsState;

  const CulturalLessonState({
    this.lessonState = const BaseState(),
    this.questionsState = const BaseState(),
  });

  CulturalLessonState copyWith({
    BaseState<CulturalLesson>? lessonState,
    BaseState<List<Question>>? questionsState,
  }) {
    return CulturalLessonState(
      lessonState: lessonState ?? this.lessonState,
      questionsState: questionsState ?? this.questionsState,
    );
  }

  @override
  List<Object?> get props => [lessonState, questionsState];
}
