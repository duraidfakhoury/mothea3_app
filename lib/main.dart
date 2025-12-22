import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mothea3_app/core/config/app_config.dart';
import 'package:mothea3_app/core/constants/api_urls.dart';
import 'package:mothea3_app/core/route/app_router.dart';
import 'package:mothea3_app/core/services/cache_service.dart';
import 'package:mothea3_app/core/services/service_locator.dart';
import 'package:mothea3_app/core/theme/app_theme.dart';
import 'package:mothea3_app/core/theme/bloc/theme_bloc.dart';
import 'package:mothea3_app/core/utils/app_locale.dart';
import 'package:mothea3_app/generated/codegen_loader.g.dart';
import 'package:mothea3_app/modules/auth/presentation/blocs/splash_bloc/splash_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ServiceLocator().init();
  await AppConfig().initVariables();
  ApisUrls().initBaseUrl(AppConfig().baseUrl);
  await CacheService.init();
  await EasyLocalization.ensureInitialized();
  // await CacheService().initCacheLanguage();

  runApp(
    EasyLocalization(
      startLocale: AppLocale().arabic,
      supportedLocales: AppLocale().supportedLocales,
      fallbackLocale: AppLocale().arabic,
      path: "resources/langs",
      assetLoader: const CodegenLoader(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SplashBloc>(
      create: (context) => sl<SplashBloc>()..add(const AppStarted()),
      child: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is InitComplete) {
            AppRouter.router.refresh();
          }
        },
        child: BlocProvider(
          create: (context) => sl<ThemeBloc>(),
          child: BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              return ResponsiveSizer(
                builder: (context, deviceType, orientation) {
                  return MaterialApp.router(
                    localizationsDelegates: context.localizationDelegates,
                    supportedLocales: context.supportedLocales,
                    locale: context.locale,
                    debugShowCheckedModeBanner: false,
                    title: 'Mothea3',
                    theme: AppTheme().darkTheme(context),
                    themeMode: state is DarkThemeActionState
                        ? ThemeMode.dark
                        : ThemeMode.light,
                    darkTheme: AppTheme().darkTheme(context),
                    routerConfig: AppRouter.router,
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
