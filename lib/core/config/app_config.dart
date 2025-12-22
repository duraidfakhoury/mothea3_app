import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';


class AppConfig {
  static AppConfig? _instance;
  AppConfig._();
  factory AppConfig() => _instance ??= AppConfig._();

  late String baseUrl;
  Future<void> initVariables() async {
    try {
      final String contents = await rootBundle.loadString('assets/config.json');
      final Map<String, dynamic> data = json.decode(contents);
      final String baseUrl = data['baseUrl'];

      this.baseUrl = baseUrl;
      debugPrint(
          "Base URL: $baseUrl");
    } catch (e) {
            debugPrint("Error in base url init: $e");
      setDefaultValues();
    }
  }

  void setDefaultValues() {
    baseUrl = '';
  }
}
