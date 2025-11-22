import 'package:equatable/equatable.dart';

class RadioLevelLesson extends Equatable {
  final String title ; 
  final int id ;
  final String status;

  const RadioLevelLesson ({required this.title, required this.id , required this.status});

  @override
  List<Object?> get props => [title , id , status ];


}