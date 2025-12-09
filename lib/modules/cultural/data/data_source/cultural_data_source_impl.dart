import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:mothea3_app/modules/cultural/data/data_source/cultural_data_source.dart';
import 'package:mothea3_app/modules/cultural/data/models/cultural_base_level_model.dart';
import 'package:mothea3_app/modules/cultural/data/models/cultural_lesson_model.dart';
import 'package:mothea3_app/modules/cultural/data/models/question_model.dart';

class CulturalDataSourceImpl extends CulturalDataSource {
  @override
  Future<List<CulturalBaseLevelModel>> getCulturalBaseLevels() async {
    // Load the local JSON file
    final String jsonString = await rootBundle.loadString(
      'assets/local_jsons/cultural_base_levels.json',
    );

    // Decode the JSON string
    final List<dynamic> jsonList = json.decode(jsonString);

    // Map each JSON object to a model
    final List<CulturalBaseLevelModel> levels = jsonList
        .map((json) => CulturalBaseLevelModel.fromJson(json))
        .toList();

    return levels;
  }

  @override
  Future<CulturalLessonModel> getLesson(int lessonId) async {
    final String jsonString = await rootBundle.loadString(
      'assets/local_jsons/cultural_lesson_$lessonId.json',
    );
    final Map<String,dynamic> jsonMap = jsonDecode(jsonString);

    return CulturalLessonModel.fromJson(jsonMap);
  }

  @override
  Future<List<QuestionModel>> getLessonQuestions(int lessonId) async {
    final String jsonString = await rootBundle.loadString(
      'assets/local_jsons/cultural_mcq_lesson_$lessonId.json',
    );

    // Decode the JSON string
    final List<dynamic> jsonList = json.decode(jsonString);

    // Map each JSON object to a model
    final List<QuestionModel> questions = jsonList
        .map((json) => QuestionModel.fromJson(json))
        .toList();

    return questions;
  }
}
