import 'package:go_router/go_router.dart';
import 'package:mothea3_app/modules/home/presentation/screens/contact_us_screen.dart';

class ContactUsRoute {

  static const String name = "/ContactUs";
  static GoRoute route = GoRoute(
    path: name,
    builder: (context, state) => ContactUsScreen(),
    );
}