import 'package:go_router/go_router.dart';
import 'package:mothea3_app/modules/radio/presentation/screens/radio_fields_screen.dart';

class RadioFieldsRoute {
  static const String name = "/radioFieldsRoute";

  static GoRoute route = GoRoute(
    path: name,
    builder: (context, state) {
      return RadioFieldsScreen();
    },
  );
}
