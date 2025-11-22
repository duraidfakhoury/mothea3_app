import 'package:dartz/dartz.dart';
import 'package:mothea3_app/core/network/exeptions/failure.dart';
import 'package:mothea3_app/modules/television/domain/entitiy/television_base_level.dart';
import 'package:mothea3_app/modules/television/domain/entitiy/television_lesson.dart';
import 'package:mothea3_app/modules/television/domain/entitiy/television_level_lesson.dart';

abstract class TelevisionRepository {

  Future<Either<Failure,List<TelevisionBaseLevel>>> getBaseLevels();
  Future<Either<Failure,List<TelevisionLevelLesson>>> getlevelLessons(int levelID);
  Future<Either<Failure,TelevisionLesson>> getTelevisionLesson(int levelId , int lessonId);

}