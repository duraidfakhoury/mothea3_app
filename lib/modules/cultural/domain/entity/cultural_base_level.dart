import 'package:equatable/equatable.dart';

class CulturalBaseLevel extends Equatable {
  final String title ; 
  final int id ;
  final String status;

  const  CulturalBaseLevel ({required this.title, required this.id , required this.status});

  @override
  List<Object?> get props => [title , id , status ];

}