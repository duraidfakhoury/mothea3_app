import 'package:mothea3_app/modules/television/domain/entitiy/television_lesson.dart';

class TelevisionLessonModel extends TelevisionLesson {
  const TelevisionLessonModel({required super.title, required super.id , required super.paragraph}); 
  factory TelevisionLessonModel.fromJson (Map<String,dynamic> json) {
    return TelevisionLessonModel(
      title: json["title"], 
      id:json["id"],
      paragraph: json["paragraph"]
       );
  }
}