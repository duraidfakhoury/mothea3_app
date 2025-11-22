import 'package:equatable/equatable.dart';

class TelevisionLesson extends Equatable {
  final String title ; 
  final int id ;
  final String paragraph;

  const TelevisionLesson({required this.title, required this.id , required this.paragraph});

  @override
  List<Object?> get props => [title , id , paragraph ];

}