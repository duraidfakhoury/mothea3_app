import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mothea3_app/core/enums/auth_status.dart';
import 'package:mothea3_app/modules/auth/presentation/blocs/splash_bloc/splash_bloc.dart';
import 'package:mothea3_app/modules/auth/presentation/routes/login_route.dart';
import 'package:mothea3_app/modules/auth/presentation/routes/register_route.dart';
import 'package:mothea3_app/modules/auth/presentation/routes/splash_route.dart';
import 'package:mothea3_app/modules/home/presentation/routes/contact_us_route.dart';
import 'package:mothea3_app/modules/home/presentation/routes/home_route.dart';
import 'package:mothea3_app/modules/home/presentation/routes/knowledge_base_route.dart';
import 'package:mothea3_app/modules/radio/presentation/routes/radio_base_levels_route.dart';
import 'package:mothea3_app/modules/radio/presentation/routes/radio_lesson_route.dart';
import 'package:mothea3_app/modules/radio/presentation/routes/radio_level_lessons_route.dart';
import 'package:mothea3_app/modules/television/presentation/routes/television_base_levels_route.dart';
import 'package:mothea3_app/modules/television/presentation/routes/television_lesson_route.dart';
import 'package:mothea3_app/modules/television/presentation/routes/television_level_lessons_route.dart';
import 'package:mothea3_app/modules/television/presentation/routes/television_recording_route.dart';

class AppRouter {

  static final router = GoRouter(
    initialLocation: SplashRoute.name,
    redirect: (context, state) {
      // Use context.read() to get the current state of the Bloc
      final initStatus = context.read<SplashBloc>().state; 
      final isSplash = state.matchedLocation == SplashRoute.name;

      // 1. If Initialization is IN PROGRESS
      if (initStatus is InitInProgress) {
        // Stay on the splash screen (return null) if that's where we are
        // Otherwise, force navigation back to the splash screen
        return isSplash ? null : SplashRoute.name; 
      }

      // 2. If Initialization is COMPLETE
      if (initStatus is InitComplete) {
        // If we are still on the splash screen, we must redirect.
        if (isSplash) {
          if (initStatus.authStatus == AuthStatus.authenticated) {
            // Initialization done, User is authenticated -> Home
            return HomeRoute.name;
          } else if (initStatus.authStatus == AuthStatus.unAuthenticated) {
            // Initialization done, User is NOT authenticated -> Login
            return LoginRoute.name;
          }
        }
        // If we are not on the splash screen, let the navigation continue normally.
        return null;
      }
      
      // Fallback
      return null;
    },
    routes: [
      SplashRoute.route,
      HomeRoute.route,
      LoginRoute.route,
      RegisterRoute.route,
      KnowledgeBaseRoute.route,
      ContactUsRoute.route,
      RadioBaseLevelsRoute.route,
      RadioLevelLessonsRoute.route,
      RadioLessonRoute.route,
      TelevisionBaseLevelsRoute.route,
      TelevisionLevelLessonsRoute.route,
      TelevisionLessonRoute.route,
      TelevisionRecordingRoute.route,
      
    ]
    );

}