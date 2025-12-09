import 'package:equatable/equatable.dart';

class CulturalLesson extends Equatable {
  final String paragraph;
  const CulturalLesson({required this.paragraph});

  @override
  List<Object?> get props => [paragraph];
}
