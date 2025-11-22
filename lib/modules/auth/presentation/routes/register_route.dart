import 'package:go_router/go_router.dart';
import 'package:mothea3_app/modules/auth/presentation/screens/register_screen.dart';

class RegisterRoute {

  static const String name = "/Register"; 
  static GoRoute route = GoRoute(
    path: name ,
    builder: (context, state) => RegisterScreen(),
    );
}