import 'package:dartz/dartz.dart';
import 'package:mothea3_app/core/network/app_errors_handler.dart';
import 'package:mothea3_app/core/network/exeptions/failure.dart';
import 'package:mothea3_app/modules/radio/data/data_source/radio_data_source.dart';
import 'package:mothea3_app/modules/radio/domian/entity/radio_base_level.dart';
import 'package:mothea3_app/modules/radio/domian/entity/radio_lesson.dart';
import 'package:mothea3_app/modules/radio/domian/entity/radio_level_lesson.dart';
import 'package:mothea3_app/modules/radio/domian/repository/radio_repository.dart';

class RadioRepositoryImpl extends RadioRepository {

  RadioDataSource radioDataSource ; 

  RadioRepositoryImpl({required this.radioDataSource});


  @override
  Future<Either<Failure, List<RadioBaseLevel>>> getBaseLevels() {
    return AppErrorsHandler().defaultHandleEither(
      () => radioDataSource.getRadioBaseLevels()
    );
  }

  @override
  Future<Either<Failure, List<RadioLevelLesson>>> getlevelLessons(int levelId) {
    return AppErrorsHandler().defaultHandleEither(
      () => radioDataSource.getRadioLevelLessons(levelId)
    );  
  }
    @override
  Future<Either<Failure, RadioLesson>> getRadioLesson( int levelId,  int lessonId) {
    return AppErrorsHandler().defaultHandleEither(
      () => radioDataSource.getRadioLesson( levelId , lessonId)
    );  
  }

  
}