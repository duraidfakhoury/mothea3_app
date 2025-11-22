import 'package:equatable/equatable.dart';

class RadioLesson extends Equatable {
  final String title ; 
  final int id ;
  final String paragraph;

  const RadioLesson({required this.title, required this.id , required this.paragraph});

  @override
  List<Object?> get props => [title , id , paragraph ];

}