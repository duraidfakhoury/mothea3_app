import 'package:dartz/dartz.dart';
import 'package:mothea3_app/core/network/exeptions/failure.dart';
import 'package:mothea3_app/modules/cultural/domain/entity/cultural_base_level.dart';
import 'package:mothea3_app/modules/cultural/domain/entity/cultural_lesson.dart';
import 'package:mothea3_app/modules/cultural/domain/entity/question.dart';

abstract class CulturalRepository {
  Future<Either<Failure, List<CulturalBaseLevel>>> getBaseLevels();
  Future<Either<Failure, CulturalLesson>> getLesson(int lessonId);
  Future<Either<Failure, List<Question>>> getLessonQuestions(int lessonId);
}
