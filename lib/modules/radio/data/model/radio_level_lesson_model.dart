
import 'package:mothea3_app/modules/radio/domian/entity/radio_level_lesson.dart';

class RadioLevelLessonModel extends RadioLevelLesson {
  const RadioLevelLessonModel ({required super.title, required super.id , required super.status}); 
  factory RadioLevelLessonModel.fromJson (Map<String,dynamic> json) {
    return RadioLevelLessonModel(
      title: json["title"], 
      id:json["id"],
      status: json["status"]
       );
  }
}