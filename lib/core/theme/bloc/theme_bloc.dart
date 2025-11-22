import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mothea3_app/core/services/cache_service.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc()
      : super(CacheService().theme
            ? DarkThemeActionState()
            : LightThemeActionState()) {
    on<SetDarkThemeEvent>((event, emit) {
      CacheService().setTheme(true);
      emit(DarkThemeActionState());
    });

    on<SetLightThemeEvent>((event, emit) {
      CacheService().setTheme(false);
      emit(LightThemeActionState());
    });
  }
}
