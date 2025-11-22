import 'package:go_router/go_router.dart';
import 'package:mothea3_app/modules/radio/domian/entity/radio_base_level.dart';
import 'package:mothea3_app/modules/radio/presentation/screens/radio_level_lessons_screen.dart';

class RadioLevelLessonsRoute {
  static const String name = "/RadioLevelLessons";

  static GoRoute route = GoRoute(
    path: name,
    builder: (context, state) {
      final level = state.extra as RadioBaseLevel;
      return RadioLevelLessonsScreen(level: level);
    },
  );
}
