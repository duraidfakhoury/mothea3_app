import 'package:go_router/go_router.dart';
import 'package:mothea3_app/modules/television/presentation/screens/televsion_fields_screen.dart';

class TelevisionFieldsRoute {
  static const String name = "/televisionFieldsRoute";

  static GoRoute route = GoRoute(
    path: name,
    builder: (context, state) {
      return TelevisionFieldsScreen();
    },
  );
}
