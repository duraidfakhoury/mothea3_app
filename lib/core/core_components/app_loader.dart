import 'package:flutter/material.dart';
import 'package:mothea3_app/core/constants/app_colors.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.navy.withOpacity(0.8),
      child: const Center(
        child: SizedBox(
          width: 55,
          height: 55,
          child: CircularProgressIndicator(
            strokeWidth: 3,
            valueColor: AlwaysStoppedAnimation(AppColors.yellow),
          ),
        ),
      ),
    );
  }
}
