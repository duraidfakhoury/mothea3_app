import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mothea3_app/generated/locale_keys.g.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(LocaleKeys.mothea3.tr(),style: Theme.of(context).textTheme.headlineLarge?.copyWith(
          fontSize: 32
        ),),
      ),
    );
  }
}