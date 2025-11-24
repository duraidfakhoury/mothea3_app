import 'package:go_router/go_router.dart';
import 'package:mothea3_app/modules/television/presentation/screens/television_pre_cond_screen.dart';

class TelevisionPreCondRoute {
  static const String name = "/televisionPreCondRoute";

  static GoRoute route = GoRoute(
    path: name,
    builder: (context, state) {
      return TelevisionPreCondScreen();
    },
  );
}
