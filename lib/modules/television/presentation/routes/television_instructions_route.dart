import 'package:go_router/go_router.dart';
import 'package:mothea3_app/modules/television/domain/entitiy/television_level_lesson.dart';
import 'package:mothea3_app/modules/television/presentation/screens/television_instructions_screen.dart';

class TelevisionInstructionsRoute {
  static const String name = "/televisionInstructions";

  static GoRoute route = GoRoute(
    path: name,
    builder: (context, state) {
      final extra = state.extra as Map<String, dynamic>;
      final levelId = extra['levelId'] as int;
      final lesson = extra['lesson'] as TelevisionLevelLesson;

      return TelevisionInstructionsScreen(
        levelId: levelId,
        lesson: lesson,
      );
    },
  );
}

