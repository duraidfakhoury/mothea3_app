import 'package:equatable/equatable.dart';

class RadioBaseLevel extends Equatable {
  final String title ; 
  final int id ;
  final bool locked;

  const RadioBaseLevel({required this.title, required this.id , required this.locked});

  @override
  List<Object?> get props => [title , id , locked ];


}