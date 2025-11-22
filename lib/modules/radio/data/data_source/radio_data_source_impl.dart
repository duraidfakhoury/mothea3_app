import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:mothea3_app/modules/radio/data/data_source/radio_data_source.dart';
import 'package:mothea3_app/modules/radio/data/model/radio_base_level_model.dart';
import 'package:mothea3_app/modules/radio/data/model/radio_lesson_model.dart';
import 'package:mothea3_app/modules/radio/data/model/radio_level_lesson_model.dart';

class RadioDataSourceImpl extends RadioDataSource {
  @override
  Future<List<RadioBaseLevelModel>> getRadioBaseLevels() async {
    // Load the local JSON file
    final String jsonString =
        await rootBundle.loadString('assets/local_jsons/radio_base_levels.json');

    // Decode the JSON string
    final List<dynamic> jsonList = json.decode(jsonString);

    // Map each JSON object to a model
    final List<RadioBaseLevelModel> levels = jsonList
        .map((json) => RadioBaseLevelModel.fromJson(json))
        .toList();

    return levels;
  }
  @override
  Future<List<RadioLevelLessonModel>> getRadioLevelLessons(int levelId) async {
    // Load the local JSON file
    final String jsonString =
        await rootBundle.loadString('assets/local_jsons/radio_level_lessons.json');

    // Decode the JSON string
    final List<dynamic> jsonList = json.decode(jsonString);

    // Map each JSON object to a model
    final List<RadioLevelLessonModel> levels = jsonList
        .map((json) => RadioLevelLessonModel.fromJson(json))
        .toList();

    return levels;
  }
    @override
  Future<RadioLessonModel> getRadioLesson(int levelId , int lessonId) async {
    // Load the local JSON file
    final String jsonString =
        await rootBundle.loadString('assets/local_jsons/radio_lesson.json');

    // Decode the JSON string
    final Map<String,dynamic> decodedJson = json.decode(jsonString);

    // Map each JSON object to a model
    final RadioLessonModel lesson = RadioLessonModel.fromJson(decodedJson);

    return lesson;
  }
}
