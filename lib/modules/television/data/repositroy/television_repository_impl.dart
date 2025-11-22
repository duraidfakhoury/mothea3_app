import 'package:dartz/dartz.dart';
import 'package:mothea3_app/core/network/app_errors_handler.dart';
import 'package:mothea3_app/core/network/exeptions/failure.dart';
import 'package:mothea3_app/modules/television/data/data_source/television_data_source.dart';
import 'package:mothea3_app/modules/television/domain/entitiy/television_base_level.dart';
import 'package:mothea3_app/modules/television/domain/entitiy/television_lesson.dart';
import 'package:mothea3_app/modules/television/domain/entitiy/television_level_lesson.dart';
import 'package:mothea3_app/modules/television/domain/repository/television_repository.dart';

class TelevisionRepositoryImpl extends TelevisionRepository {

  TelevisionDataSource televisionDataSource ; 

  TelevisionRepositoryImpl({required this.televisionDataSource});


  @override
  Future<Either<Failure, List<TelevisionBaseLevel>>> getBaseLevels() {
    return AppErrorsHandler().defaultHandleEither(
      () => televisionDataSource.getTelevisionBaseLevels()
    );
  }

  @override
  Future<Either<Failure, List<TelevisionLevelLesson>>> getlevelLessons(int levelId) {
    return AppErrorsHandler().defaultHandleEither(
      () => televisionDataSource.getTelevisionLevelLessons(levelId)
    );  
  }
    @override
  Future<Either<Failure, TelevisionLesson>> getTelevisionLesson( int levelId,  int lessonId) {
    return AppErrorsHandler().defaultHandleEither(
      () => televisionDataSource.getTelevisionLesson( levelId , lessonId)
    );  
  }

  
}