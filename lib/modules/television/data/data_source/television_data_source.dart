import 'package:mothea3_app/modules/television/data/models/television_base_level_model.dart';
import 'package:mothea3_app/modules/television/data/models/television_lesson_model.dart';
import 'package:mothea3_app/modules/television/data/models/television_level_lesson_model.dart';


abstract class  TelevisionDataSource{

  Future<List<TelevisionBaseLevelModel>> getTelevisionBaseLevels();
  Future<List<TelevisionLevelLessonModel>> getTelevisionLevelLessons(int levelId);
  Future<TelevisionLessonModel> getTelevisionLesson( int levelId , int lessonId );

}