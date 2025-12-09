import 'package:go_router/go_router.dart';
import 'package:mothea3_app/modules/cultural/presentation/screens/cultural_base_levels_screen.dart';

class CulturalBaseLevelsRoute {

  static const String name = "/culturallBaseLevels"; 
  static GoRoute route = GoRoute(
    path: name ,
    builder: (context, state) => CulturalBaseLevelsScreen(),
    );
}