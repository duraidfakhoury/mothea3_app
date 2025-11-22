import 'package:go_router/go_router.dart';
import 'package:mothea3_app/modules/television/presentation/screens/television_base_levels_screen.dart';

class TelevisionBaseLevelsRoute {

  static const String name = "/televisionBaseLevels"; 
  static GoRoute route = GoRoute(
    path: name ,
    builder: (context, state) => TelevisionBaseLevelsScreen(),
    );
}