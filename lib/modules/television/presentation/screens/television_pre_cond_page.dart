import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mothea3_app/core/constants/app_colors.dart';
import 'package:mothea3_app/generated/locale_keys.g.dart';

class TelevisionPreCondPage extends StatelessWidget {
  const TelevisionPreCondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
          ),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
              size: 20,
            ),
            onPressed: () => context.pop(),
          ),
        ),
        centerTitle: true,
        title: Text.rich(
          TextSpan(
            text: LocaleKeys.section.tr(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
            children: [
              TextSpan(
                text: LocaleKeys.closed.tr(),
                style: TextStyle(
                  color: AppColors.yellow,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys
                    .wedLoveToHearFromYouReachOutForInquiriessupportOrPartnershipOpportunities
                    .tr(),
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 40),

              // Contact Card: Email
              _contactCard(
                icon: Icons.email_outlined,
                title: LocaleKeys.emailUs.tr(),
                text: LocaleKeys.ourEmail.tr(),
              ),

              const SizedBox(height: 24),

              // Contact Card: Phone
              _contactCard(
                icon: Icons.phone_in_talk_outlined,
                title: LocaleKeys.callUs.tr(),
                text: LocaleKeys.ourNumber.tr(),
              ),

              const SizedBox(height: 24),

              // Contact Card: Social Media
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.navyAccent,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.yellow.withOpacity(0.4),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: AppColors.yellow.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.share_outlined,
                        color: AppColors.yellow,
                        size: 28,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      LocaleKeys.followUS.tr(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _socialButton(Icons.facebook, 'Facebook'),
                        const SizedBox(width: 16),
                        _socialButton(Icons.camera_alt_outlined, 'Instagram'),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // Reusable contact card widget
  Widget _contactCard({
    required IconData icon,
    required String title,
    required String text,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.navyAccent,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.yellow.withOpacity(0.4),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: AppColors.yellow.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.yellow, size: 28),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 15,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  // Social media button (icon + glow)
  static Widget _socialButton(IconData icon, String label) {
    return InkWell(
      onTap: () {
        // Add link handling here
      },
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.yellow.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: AppColors.yellow, size: 26),
      ),
    );
  }
}
