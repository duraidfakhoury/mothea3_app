import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mothea3_app/core/constants/app_colors.dart';
import 'package:mothea3_app/core/core_components/return_button.dart';
import 'package:mothea3_app/generated/locale_keys.g.dart';
import 'package:mothea3_app/modules/television/presentation/routes/television_base_levels_route.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TelevisionFieldsScreen extends StatelessWidget {
  const TelevisionFieldsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: ReturnButton(onTap: () => context.pop()),
        centerTitle: true,
        title: Text(
          LocaleKeys.televisionSection.tr(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: 1),
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeOutCubic,
                builder: (context, value, child) => Opacity(
                  opacity: value,
                  child: Transform.translate(
                    offset: Offset(0, 20 * (1 - value)),
                    child: child,
                  ),
                ),
                child: Center(
                  child: Text(
                    LocaleKeys.chooseYourField.tr(),
                    style: const TextStyle(
                      color: AppColors.yellow,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: 1),
                duration: const Duration(milliseconds: 1000),
                curve: Curves.easeOutCubic,
                builder: (context, value, child) => Opacity(
                  opacity: value,
                  child: Transform.translate(
                    offset: Offset(0, 20 * (1 - value)),
                    child: child,
                  ),
                ),
                child: Center(
                  child: Text(
                    LocaleKeys.selectTheFieldYouWanToExplor.tr(),
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.6),
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: 1),
                duration: const Duration(milliseconds: 1600),
                curve: Curves.easeOutCubic,
                builder: (context, value, child) => Opacity(
                  opacity: value,
                  child: Transform.translate(
                    offset: Offset(0, 30 * (1 - value)),
                    child: Transform.scale(
                      scale: 0.9 + (0.1 * value),
                      child: child,
                    ),
                  ),
                ),
                child: _buildFieldCard(
                  context: context,
                  title: LocaleKeys.PoliticalField.tr(),
                  icon: Icons.account_balance_rounded,
                  gradient: [
                    Colors.purple.withOpacity(0.8),
                    Colors.deepPurple.withOpacity(0.6),
                  ],
                  glowColor: Colors.purple,
                  onTap: () {
                    context.push(TelevisionBaseLevelsRoute.name);
                  },
                ),
              ),

              const SizedBox(height: 20),

              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: 1),
                duration: const Duration(milliseconds: 1800),
                curve: Curves.easeOutCubic,
                builder: (context, value, child) => Opacity(
                  opacity: value,
                  child: Transform.translate(
                    offset: Offset(0, 30 * (1 - value)),
                    child: Transform.scale(
                      scale: 0.9 + (0.1 * value),
                      child: child,
                    ),
                  ),
                ),
                child: _buildFieldCard(
                  context: context,
                  title: LocaleKeys.economicalField.tr(),
                  icon: Icons.trending_up_rounded,
                  gradient: [
                    Colors.green.withOpacity(0.8),
                    Colors.teal.withOpacity(0.6),
                  ],
                  glowColor: Colors.green,
                  onTap: () {
                    context.push(TelevisionBaseLevelsRoute.name);
                  },
                ),
              ),

              const SizedBox(height: 20),

              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: 1),
                duration: const Duration(milliseconds: 2000),
                curve: Curves.easeOutCubic,
                builder: (context, value, child) => Opacity(
                  opacity: value,
                  child: Transform.translate(
                    offset: Offset(0, 30 * (1 - value)),
                    child: Transform.scale(
                      scale: 0.9 + (0.1 * value),
                      child: child,
                    ),
                  ),
                ),
                child: _buildFieldCard(
                  context: context,
                  title: LocaleKeys.sportField.tr(),
                  icon: Icons.sports_soccer_rounded,
                  gradient: [
                    Colors.orange.withOpacity(0.8),
                    Colors.deepOrange.withOpacity(0.6),
                  ],
                  glowColor: Colors.orange,
                  onTap: () {
                    // Navigate to cultural field
                  },
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFieldCard({
    required BuildContext context,
    required String title,
    required IconData icon,
    required List<Color> gradient,
    required Color glowColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(3.w),
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(5.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(4.w),
          border: Border.all(
            color: Colors.white.withOpacity(0.2),
            width: 0.3.w,
          ),
          boxShadow: [
            BoxShadow(
              color: glowColor.withOpacity(0.3),
              blurRadius: 3.w,
              offset: Offset(0, 1.h),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              height: 10.h,
              width: 10.h,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(3.w),
                border: Border.all(
                  color: Colors.white.withOpacity(0.3),
                  width: 0.5.w,
                ),
              ),
              child: Icon(icon, color: Colors.white, size: 6.h),
            ),

            SizedBox(width: 4.w),

            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 21.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            Container(
              padding: EdgeInsets.all(2.w),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(2.w),
              ),
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.white,
                size: 17.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
