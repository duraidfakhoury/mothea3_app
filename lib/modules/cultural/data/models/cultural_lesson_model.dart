import 'package:mothea3_app/modules/cultural/domain/entity/cultural_lesson.dart';

class CulturalLessonModel extends CulturalLesson {
  const CulturalLessonModel({required super.paragraph});
  factory CulturalLessonModel.fromJson(Map<String, dynamic> json) {
    return CulturalLessonModel(paragraph: json["paragraph"]);
  }
}
