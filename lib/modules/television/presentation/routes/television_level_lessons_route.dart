import 'package:go_router/go_router.dart';

import 'package:mothea3_app/modules/television/domain/entitiy/television_base_level.dart';
import 'package:mothea3_app/modules/television/presentation/screens/television_level_lessons_screen.dart';

class TelevisionLevelLessonsRoute {
  static const String name = "/televisionLevelLessons";

  static GoRoute route = GoRoute(
    path: name,
    builder: (context, state) {
      final level = state.extra as TelevisionBaseLevel;
      return TelevisionLevelLessonsScreen(level: level);
    },
  );
}
