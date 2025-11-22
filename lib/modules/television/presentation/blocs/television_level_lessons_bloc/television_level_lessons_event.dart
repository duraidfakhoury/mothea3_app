part of 'television_level_lessons_bloc.dart';

sealed  class TelevisionLevelLessonsEvent extends Equatable {
  const TelevisionLevelLessonsEvent();

}

class GetLevelLessonsEvent extends TelevisionLevelLessonsEvent {
  final int levelId;
  const GetLevelLessonsEvent({required this.levelId});
  @override
  List<Object?> get props => [levelId];
}

