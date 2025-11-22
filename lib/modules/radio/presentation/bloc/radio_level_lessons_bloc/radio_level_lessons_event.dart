part of 'radio_level_lessons_bloc.dart';

sealed  class RadioLevelLessonsEvent extends Equatable {
  const RadioLevelLessonsEvent();

}

class GetLevelLessonsEvent extends RadioLevelLessonsEvent {
  final int levelId;
  const GetLevelLessonsEvent({required this.levelId});
  @override
  List<Object?> get props => [levelId];
}

