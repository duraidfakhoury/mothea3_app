import 'package:mothea3_app/modules/cultural/data/models/cultural_base_level_model.dart';
import 'package:mothea3_app/modules/cultural/data/models/cultural_lesson_model.dart';
import 'package:mothea3_app/modules/cultural/data/models/question_model.dart';

abstract class CulturalDataSource {
  Future<List<CulturalBaseLevelModel>> getCulturalBaseLevels();
  Future<CulturalLessonModel> getLesson(int lessonId);
  Future<List<QuestionModel>> getLessonQuestions(int lessonId);
}
