import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart';
import 'package:mothea3_app/core/enums/app_languages.dart';
import 'package:mothea3_app/core/services/cache_service.dart';
import 'package:mothea3_app/core/theme/app_theme.dart';

class AppLocale {
  static AppLocale? _instance ; 
  AppLocale._();
  factory AppLocale() => _instance ??= AppLocale._();  

  final Locale arabic = const Locale("ar" , "SY");
  final Locale english = const Locale("en" , "US");

  AppLanguages currentLanguage(BuildContext context) {
    if(context.locale == arabic ) return AppLanguages.arabic ; 
    return AppLanguages.english;
  }

  AppLanguages currentCacheLanguage() {
    return CacheService().language
    ? AppLanguages.arabic 
    : AppLanguages.english;
  }

  String get languageCode {
    switch (currentCacheLanguage()){
      case  AppLanguages.arabic :
        return "ar";
      case AppLanguages.english : 
        return "en";
    }
  }

  Locale currentLocale(BuildContext context){
    Logger().d("${context.locale}");
    return context.locale;
  }

  List<Locale> get supportedLocales => [english , arabic];

  void changeLanguage(BuildContext context , AppLanguages newLanguage) async {
    Locale currentLocale = context.locale; 
    final currentLang = currentLanguage(context);

    if(currentLang == newLanguage) return;

    switch(currentLang){
      case AppLanguages.arabic : 
        currentLocale = english; 
        CacheService().setLanguage(false); 
        break;
      case AppLanguages.english : 
      currentLocale = arabic; 
      CacheService().setLanguage(true);
      break;
    }

    await context.setLocale(currentLocale);

    if (!context.mounted) return;
    AppTheme().refreshTheme(context);
  }

    // Checks if the current language is English
  bool isEnglish(BuildContext context) =>
      currentLanguage(context) == AppLanguages.english;

  // Checks if the current language is Arabic
  bool isArabic(BuildContext context) =>
      currentLanguage(context) == AppLanguages.arabic;
}