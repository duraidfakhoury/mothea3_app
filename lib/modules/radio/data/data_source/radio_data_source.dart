import 'package:mothea3_app/modules/radio/data/model/radio_base_level_model.dart';
import 'package:mothea3_app/modules/radio/data/model/radio_lesson_model.dart';
import 'package:mothea3_app/modules/radio/data/model/radio_level_lesson_model.dart';

abstract class RadioDataSource {

  Future<List<RadioBaseLevelModel>> getRadioBaseLevels();
  Future<List<RadioLevelLessonModel>> getRadioLevelLessons(int levelId);
  Future<RadioLessonModel> getRadioLesson( int levelId , int lessonId );


}