import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:mothea3_app/modules/television/data/data_source/television_data_source.dart';
import 'package:mothea3_app/modules/television/data/models/television_base_level_model.dart';
import 'package:mothea3_app/modules/television/data/models/television_lesson_model.dart';
import 'package:mothea3_app/modules/television/data/models/television_level_lesson_model.dart';

class TelevisionDataSourceImpl extends TelevisionDataSource {
  @override
  Future<List<TelevisionBaseLevelModel>> getTelevisionBaseLevels() async {
    // Load the local JSON file
    final String jsonString = await rootBundle.loadString(
      'assets/local_jsons/television_base_levels.json',
    );

    // Decode the JSON string
    final List<dynamic> jsonList = json.decode(jsonString);

    // Map each JSON object to a model
    final List<TelevisionBaseLevelModel> levels = jsonList
        .map((json) => TelevisionBaseLevelModel.fromJson(json))
        .toList();

    return levels;
  }

  @override
  Future<List<TelevisionLevelLessonModel>> getTelevisionLevelLessons(
    int levelId,
  ) async {
    // Load the local JSON file
    print('assets/local_jsons/television_level_${levelId}_lessons.json');
    final String jsonString = await rootBundle.loadString(
      'assets/local_jsons/television_level_${levelId}_lessons.json',
    );

    // Decode the JSON string
    final List<dynamic> jsonList = json.decode(jsonString);

    // Map each JSON object to a model
    final List<TelevisionLevelLessonModel> levels = jsonList
        .map((json) => TelevisionLevelLessonModel.fromJson(json))
        .toList();

    return levels;
  }

  @override
  Future<TelevisionLessonModel> getTelevisionLesson(
    int levelId,
    int lessonId,
  ) async {
    // Load the local JSON file
    final String jsonString = await rootBundle.loadString(
      'assets/local_jsons/television_lesson.json',
    );

    // Decode the JSON string
    final Map<String, dynamic> decodedJson = json.decode(jsonString);

    // Map each JSON object to a model
    final TelevisionLessonModel lesson = TelevisionLessonModel.fromJson(
      decodedJson,
    );

    return lesson;
  }
}
