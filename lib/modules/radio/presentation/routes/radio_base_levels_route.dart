import 'package:go_router/go_router.dart';
import 'package:mothea3_app/modules/radio/presentation/screens/radio_base_levels_screen.dart';

class RadioBaseLevelsRoute {

  static const String name = "/RadioBaseLevels"; 
  static GoRoute route = GoRoute(
    path: name ,
    builder: (context, state) => RadioBaseLevelsScreen(),
    );
}