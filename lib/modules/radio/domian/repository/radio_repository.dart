import 'package:dartz/dartz.dart';
import 'package:mothea3_app/core/network/exeptions/failure.dart';
import 'package:mothea3_app/modules/radio/domian/entity/radio_base_level.dart';
import 'package:mothea3_app/modules/radio/domian/entity/radio_lesson.dart';
import 'package:mothea3_app/modules/radio/domian/entity/radio_level_lesson.dart';

abstract class RadioRepository {

  Future<Either<Failure,List<RadioBaseLevel>>> getBaseLevels();
  Future<Either<Failure,List<RadioLevelLesson>>> getlevelLessons(int levelID);
  Future<Either<Failure,RadioLesson>> getRadioLesson(int levelId , int lessonId);


}