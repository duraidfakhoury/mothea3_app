part of 'radio_lesson_bloc.dart';

sealed  class RadioLessonEvent extends Equatable {
  const RadioLessonEvent();

}

class GetRadioLessonEvent extends RadioLessonEvent {
  final int levelId;
  final int lessonId;
  const GetRadioLessonEvent({required this.lessonId , required this.levelId});

  @override
  List<Object?> get props => [lessonId , levelId];
}

