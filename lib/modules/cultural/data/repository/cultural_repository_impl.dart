import 'package:dartz/dartz.dart';
import 'package:mothea3_app/core/network/app_errors_handler.dart';
import 'package:mothea3_app/core/network/exeptions/failure.dart';
import 'package:mothea3_app/modules/cultural/data/data_source/cultural_data_source.dart';
import 'package:mothea3_app/modules/cultural/domain/entity/cultural_base_level.dart';
import 'package:mothea3_app/modules/cultural/domain/entity/cultural_lesson.dart';
import 'package:mothea3_app/modules/cultural/domain/entity/question.dart';
import 'package:mothea3_app/modules/cultural/domain/repository/cultural_repository.dart';

class CulturalRepositoryImpl extends CulturalRepository {
  CulturalDataSource culturalDataSource;

  CulturalRepositoryImpl({required this.culturalDataSource});

  @override
  Future<Either<Failure, List<CulturalBaseLevel>>> getBaseLevels() {
    return AppErrorsHandler().defaultHandleEither(
      () => culturalDataSource.getCulturalBaseLevels(),
    );
  }

  @override
  Future<Either<Failure, CulturalLesson>> getLesson(int lessonId) {
    return AppErrorsHandler().defaultHandleEither(
      () => culturalDataSource.getLesson(lessonId),
    );
  }

  @override
  Future<Either<Failure, List<Question>>> getLessonQuestions(int lessonId) {
    return AppErrorsHandler().defaultHandleEither(
      () => culturalDataSource.getLessonQuestions(lessonId),
    );
  }
}
