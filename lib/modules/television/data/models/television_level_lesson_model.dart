import 'package:mothea3_app/modules/television/domain/entitiy/television_level_lesson.dart';

class TelevisionLevelLessonModel extends TelevisionLevelLesson {
  const TelevisionLevelLessonModel ({required super.title, required super.id , required super.status}); 
  factory TelevisionLevelLessonModel.fromJson (Map<String,dynamic> json) {
    return TelevisionLevelLessonModel(
      title: json["title"], 
      id:json["id"],
      status: json["status"]
       );
  }
}