import 'package:go_router/go_router.dart';
import 'package:mothea3_app/modules/auth/presentation/screens/splash_screen.dart';

class SplashRoute {
  static const String name = "/" ; 

  static GoRoute route = GoRoute(
    path: name,
    builder: (context, state) => SplashScreen(),
    );

}