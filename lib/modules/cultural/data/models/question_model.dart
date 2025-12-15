import 'package:mothea3_app/modules/cultural/domain/entity/question.dart';

class QuestionModel extends Question {
  const QuestionModel({
    required super.id,
    required super.options,
    required super.question,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json["id"],
      options: Map<String, String>.from(json['options']),
      question: json["question"],
    );
  }
}
