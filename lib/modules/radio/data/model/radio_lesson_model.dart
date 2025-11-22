import 'package:mothea3_app/modules/radio/domian/entity/radio_lesson.dart';

class RadioLessonModel extends RadioLesson {
  const RadioLessonModel({required super.title, required super.id , required super.paragraph}); 
  factory RadioLessonModel.fromJson (Map<String,dynamic> json) {
    return RadioLessonModel(
      title: json["title"], 
      id:json["id"],
      paragraph: json["paragraph"]
       );
  }
}