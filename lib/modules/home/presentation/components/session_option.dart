import 'package:flutter/material.dart';
import 'package:mothea3_app/core/constants/app_colors.dart';

class SessionOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool locked;
  final VoidCallback onTap;

  const SessionOption({
    super.key,
    required this.icon,
    required this.title,
    this.locked = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.navyAccent.withOpacity(0.4),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.white),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, color: AppColors.yellow, size: 26),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.greyAccent,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            if (locked)
              const Icon(Icons.lock, color: AppColors.white, size: 26),
          ],
        ),
      ),
    );
  }
}
