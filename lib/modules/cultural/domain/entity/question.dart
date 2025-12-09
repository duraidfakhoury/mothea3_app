import 'package:equatable/equatable.dart';

class Question extends Equatable {
  final int id;
  final String question;
  final Map<String, String> options;

  const Question({
    required this.id,
    required this.options,
    required this.question,
  });

  @override
  List<Object?> get props => [id, options, question];
}
