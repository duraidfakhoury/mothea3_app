part of 'television_lesson_bloc.dart';

sealed  class TelevisionLessonEvent extends Equatable {
  const TelevisionLessonEvent();

}

class GetTelevisionLessonEvent extends TelevisionLessonEvent {
  final int levelId;
  final int lessonId;
  const GetTelevisionLessonEvent({required this.lessonId , required this.levelId});

  @override
  List<Object?> get props => [lessonId , levelId];
}

