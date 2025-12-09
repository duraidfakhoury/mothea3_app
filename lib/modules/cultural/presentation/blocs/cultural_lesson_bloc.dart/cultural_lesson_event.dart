part of 'cultural_lesson_bloc.dart';

sealed class CulturalLessonEvent extends Equatable {
  const CulturalLessonEvent();
}

class GetLessonEvent extends CulturalLessonEvent {
  final int lessonId;

  const GetLessonEvent({required this.lessonId});
  @override
  List<Object?> get props => [lessonId];
}

class GetLessonQuestionsEvent extends CulturalLessonEvent {
  final int lessonId;

  const GetLessonQuestionsEvent({required this.lessonId});
  @override
  List<Object?> get props => [lessonId];
}
