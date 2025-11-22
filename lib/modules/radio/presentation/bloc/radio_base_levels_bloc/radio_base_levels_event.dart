part of 'radio_base_levels_bloc.dart';

sealed  class RadioBaseLevelsEvent extends Equatable {
  const RadioBaseLevelsEvent();

}

class GetBaseLevelsEvent extends RadioBaseLevelsEvent {
  @override
  List<Object?> get props => [];
}

