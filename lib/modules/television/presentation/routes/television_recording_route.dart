import 'package:go_router/go_router.dart';
import 'package:mothea3_app/modules/television/presentation/screens/television_recording_screen.dart';

class TelevisionRecordingRoute {
  static const String name = "/televisionRecording";

  static GoRoute route = GoRoute(
    path: name,
    builder: (context, state) {
      final paragraph = state.extra as String;
      return TelevisionRecordingScreen(paragraph: paragraph);
    },
  );
}
