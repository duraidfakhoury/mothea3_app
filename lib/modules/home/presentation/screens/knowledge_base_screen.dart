import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mothea3_app/core/constants/app_colors.dart';
import 'package:mothea3_app/generated/locale_keys.g.dart';

class KnowledgeBaseScreen extends StatelessWidget {
const KnowledgeBaseScreen({super.key});

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
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20),
            onPressed: () => context.pop(),
          ),
        ),
        centerTitle: true,
        title: Text.rich(
TextSpan(
text: LocaleKeys.whyChoose.tr(),
style: const TextStyle(
color: Colors.white,
fontSize: 26,
fontWeight: FontWeight.bold,
),
children:  [
TextSpan(
text: LocaleKeys.mothea33.tr(),
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

// Title Section

Text(
LocaleKeys.weOfferTheBestPublicSpeakingLearningExperienceWithExpertTrainersAndHandsOnTraining.tr(),
style: TextStyle(
color: Colors.white70,
fontSize: 16,
height: 1.5,
),
),
const SizedBox(height: 40),


          // Feature Card 1
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
                    Icons.verified_user,
                    color: AppColors.yellow,
                    size: 28,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  LocaleKeys.expertTrainers.tr(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  LocaleKeys.learnFromCertifiedPublicSpeakingExpertsWithYearsOfIndustryExperienceAndRealWorldExpertise.tr(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 15,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Feature Card 2 (example placeholder)
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
                    Icons.unfold_more_double_outlined,
                    color: AppColors.yellow,
                    size: 28,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  LocaleKeys.handsOnTraining.tr(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  LocaleKeys.gainRealWorldPracticalExperienceByReadingMockTVAndRadioScriptsAndGuidedExercises.tr(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 15,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  ),
);
}
}
