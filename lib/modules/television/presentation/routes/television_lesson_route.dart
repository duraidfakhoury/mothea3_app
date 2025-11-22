import 'package:go_router/go_router.dart';
import 'package:mothea3_app/modules/television/domain/entitiy/television_level_lesson.dart';
import 'package:mothea3_app/modules/television/presentation/screens/television_lesson_screen.dart';

class TelevisionLessonRoute {
  static const String name = "/televisionLesson";

  static GoRoute route = GoRoute(
    path: name,
    builder: (context, state) {
      final extra = state.extra as Map<String, dynamic>;
      final levelId = extra['levelId'] as int;
      final lesson = extra['lesson'] as TelevisionLevelLesson; // your TelevisionLevelLesson object
      
      return TelevisionLessonScreen(lesson: lesson ,levelId: levelId );
    },
  );
}
