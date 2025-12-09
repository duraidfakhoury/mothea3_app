part of 'cultural_base_levels_bloc.dart';

sealed  class CulturalBaseLevelsEvent extends Equatable {
  const CulturalBaseLevelsEvent();

}

class GetBaseLevelsEvent extends CulturalBaseLevelsEvent {
  @override
  List<Object?> get props => [];
}

