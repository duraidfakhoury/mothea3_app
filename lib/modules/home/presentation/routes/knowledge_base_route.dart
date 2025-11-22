import 'package:go_router/go_router.dart';
import 'package:mothea3_app/modules/home/presentation/screens/knowledge_base_screen.dart';

class KnowledgeBaseRoute {

  static const String name = "/KnowledgeBase";
  static GoRoute route = GoRoute(
    path: name,
    builder: (context, state) => KnowledgeBaseScreen(),
    );
}