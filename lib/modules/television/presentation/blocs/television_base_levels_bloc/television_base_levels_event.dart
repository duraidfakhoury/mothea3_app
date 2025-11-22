part of 'television_base_levels_bloc.dart';

sealed  class TelevisionBaseLevelsEvent extends Equatable {
  const TelevisionBaseLevelsEvent();

}

class GetBaseLevelsEvent extends TelevisionBaseLevelsEvent {
  @override
  List<Object?> get props => [];
}

