import 'package:go_router/go_router.dart';
import 'package:mothea3_app/modules/auth/presentation/screens/login_screen.dart';

class LoginRoute {

  static const String name = "/Login"; 
  static GoRoute route = GoRoute(
    path: name ,
    builder: (context, state) => LoginScreen(),
    );
}