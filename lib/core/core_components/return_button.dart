import 'package:flutter/material.dart';
import 'package:mothea3_app/core/constants/app_colors.dart';

class ReturnButton extends StatelessWidget {
  final VoidCallback onTap;
  const ReturnButton({super.key , required this.onTap });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.white.withOpacity(0.2), width: 1),
      ),
      child: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new_rounded,
          color: AppColors.white,
          size: 20,
        ),
        onPressed: onTap,
      ),
    );
  }
}
