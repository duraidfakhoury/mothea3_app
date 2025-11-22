import 'package:go_router/go_router.dart';
import 'package:mothea3_app/modules/radio/domian/entity/radio_level_lesson.dart';
import 'package:mothea3_app/modules/radio/presentation/screens/radio_lesson_screen.dart';

class RadioLessonRoute {
  static const String name = "/RadioLesson";

  static GoRoute route = GoRoute(
    path: name,
    builder: (context, state) {
      final extra = state.extra as Map<String, dynamic>;
      final levelId = extra['levelId'] as int;
      final lesson = extra['lesson'] as RadioLevelLesson; // your RadioLevelLesson object
      
      return RadioLessonScreen(lesson: lesson ,levelId: levelId );
    },
  );
}
