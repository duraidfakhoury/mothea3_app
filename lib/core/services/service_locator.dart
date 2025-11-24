import 'package:get_it/get_it.dart';
import 'package:mothea3_app/core/theme/bloc/theme_bloc.dart';
import 'package:mothea3_app/modules/auth/data/data_source/auth_data_source.dart';
import 'package:mothea3_app/modules/auth/data/data_source/auth_data_source_impl.dart';
import 'package:mothea3_app/modules/auth/data/repository/auth_repository_impl.dart';
import 'package:mothea3_app/modules/auth/domain/repository/auth_repository.dart';
import 'package:mothea3_app/modules/auth/presentation/blocs/login_bloc/login_bloc.dart';
import 'package:mothea3_app/modules/auth/presentation/blocs/register_bloc/register_bloc.dart';
import 'package:mothea3_app/modules/auth/presentation/blocs/splash_bloc/splash_bloc.dart';
import 'package:mothea3_app/modules/home/presentation/blocs/user_bloc/user_bloc.dart';
import 'package:mothea3_app/modules/radio/data/data_source/radio_data_source.dart';
import 'package:mothea3_app/modules/radio/data/data_source/radio_data_source_impl.dart';
import 'package:mothea3_app/modules/radio/data/repository/radio_repository_impl.dart';
import 'package:mothea3_app/modules/radio/domian/repository/radio_repository.dart';
import 'package:mothea3_app/modules/radio/presentation/bloc/radio_base_levels_bloc/radio_base_levels_bloc.dart';
import 'package:mothea3_app/modules/radio/presentation/bloc/radio_lesson_bloc/radio_lesson_bloc.dart';
import 'package:mothea3_app/modules/radio/presentation/bloc/radio_level_lessons_bloc/radio_level_lessons_bloc.dart';
import 'package:mothea3_app/modules/television/data/data_source/television_data_source.dart';
import 'package:mothea3_app/modules/television/data/data_source/television_data_source_impl.dart';
import 'package:mothea3_app/modules/television/data/repositroy/television_repository_impl.dart';
import 'package:mothea3_app/modules/television/domain/repository/television_repository.dart';
import 'package:mothea3_app/modules/television/presentation/blocs/television_base_levels_bloc/television_base_levels_bloc.dart';
import 'package:mothea3_app/modules/television/presentation/blocs/television_lesson_bloc/television_lesson_bloc.dart';
import 'package:mothea3_app/modules/television/presentation/blocs/television_level_lessons_bloc/television_level_lessons_bloc.dart';

final sl = GetIt.instance;

class ServiceLocator {
  static ServiceLocator? _instance;
  ServiceLocator._();
  factory ServiceLocator() => _instance ?? ServiceLocator._();

  void init() {
  // Theme Bloc 
  sl.registerFactory(() => ThemeBloc());

  // Data sources
  sl.registerLazySingleton<AuthDataSource>(() => AuthDataSourceImpl());
  sl.registerLazySingleton<RadioDataSource>(() => RadioDataSourceImpl());
  sl.registerLazySingleton<TelevisionDataSource>(() => TelevisionDataSourceImpl());

  // Repositories
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton<RadioRepository>(() => RadioRepositoryImpl(radioDataSource: sl()));
  sl.registerLazySingleton<TelevisionRepository>(() => TelevisionRepositoryImpl(televisionDataSource: sl()));

  // Auth Blocs
  sl.registerFactory(() => SplashBloc(auth: sl()));
  sl.registerFactory(() => LoginBloc(sl()));
  sl.registerFactory(() => RegisterBloc(sl()));
  sl.registerFactory(()=> UserBloc(sl()));

  // Radio Blocs 
  sl.registerLazySingleton(() => RadioBaseLevelsBloc(sl()));
  sl.registerLazySingleton(() => RadioLevelLessonsBloc(sl()));
  sl.registerLazySingleton(() => RadioLessonBloc(sl()));

  // Television Blocs 
  sl.registerLazySingleton(() => TelevisionBaseLevelsBloc(sl()));
  sl.registerLazySingleton(() => TelevisionLevelLessonsBloc(sl()));
  sl.registerLazySingleton(() => TelevisionLessonBloc(sl()));
}
}