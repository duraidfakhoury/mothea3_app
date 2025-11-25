import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mothea3_app/core/constants/app_colors.dart';
import 'package:mothea3_app/core/core_components/return_button.dart';
import 'package:mothea3_app/generated/locale_keys.g.dart';
import 'package:mothea3_app/modules/home/presentation/components/contact_card.dart';
import 'package:mothea3_app/modules/home/presentation/components/social_button.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: ReturnButton(onTap: () => context.pop(),),
        centerTitle: true,
        title: Text.rich(
          TextSpan(
            text: LocaleKeys.contact.tr(),
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
            children: [
              TextSpan(
                text: LocaleKeys.us.tr(),
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

              ContactCard(
                icon: Icons.email_outlined,
                title: LocaleKeys.emailUs.tr(),
                text: LocaleKeys.ourEmail.tr(),
              ),

              const SizedBox(height: 24),

              ContactCard(
                icon: Icons.phone_in_talk_outlined,
                title: LocaleKeys.callUs.tr(),
                text: LocaleKeys.ourNumber.tr(),
              ),

              const SizedBox(height: 24),

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
                        SocialButton(icon: Icons.facebook, onTap: () {}),
                        const SizedBox(width: 16),
                        SocialButton(
                          icon: Icons.camera_alt_outlined,
                          onTap: () {},
                        ),
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
}
