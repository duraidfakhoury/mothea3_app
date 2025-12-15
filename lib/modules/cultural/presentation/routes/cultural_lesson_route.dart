import 'package:go_router/go_router.dart';
import 'package:mothea3_app/modules/cultural/presentation/screens/cultural_lesson_screen.dart';

class CulturalLessonRoute {
  static const String name = "/culturalLesson";

  static GoRoute route = GoRoute(
    path: name,
    builder: (context, state) {
      final lessonId = state.extra as int;
      return CulturalLessonScreen(lessonId: lessonId);
    },
  );
}
