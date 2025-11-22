import 'package:go_router/go_router.dart';
import 'package:mothea3_app/modules/home/presentation/screens/home_screen.dart';

class HomeRoute {

  static const String name = "/Home";
  static GoRoute route = GoRoute(
    path: name,
    builder: (context, state) => HomeScreen(),
    );
}