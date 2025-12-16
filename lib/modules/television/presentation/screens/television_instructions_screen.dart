import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mothea3_app/core/constants/app_colors.dart';
import 'package:mothea3_app/core/core_components/app_button.dart';
import 'package:mothea3_app/core/core_components/return_button.dart';
import 'package:mothea3_app/modules/television/presentation/routes/television_lesson_route.dart';
import 'package:mothea3_app/modules/television/domain/entitiy/television_level_lesson.dart';
import 'package:mothea3_app/core/services/cache_service.dart';

class TelevisionInstructionsScreen extends StatelessWidget {
  final int levelId;
  final TelevisionLevelLesson lesson;

  const TelevisionInstructionsScreen({
    super.key,
    required this.levelId,
    required this.lesson,
  });

  static const _items = [
    {
      "titleKey": "televisionInstructions.items.1_title",
      "descKey": "televisionInstructions.items.1_desc",
    },
    {
      "titleKey": "televisionInstructions.items.2_title",
      "descKey": "televisionInstructions.items.2_desc",
    },
    {
      "titleKey": "televisionInstructions.items.3_title",
      "descKey": "televisionInstructions.items.3_desc",
    },
    {
      "titleKey": "televisionInstructions.items.4_title",
      "descKey": "televisionInstructions.items.4_desc",
    },
    {
      "titleKey": "televisionInstructions.items.5_title",
      "descKey": "televisionInstructions.items.5_desc",
    },
    {
      "titleKey": "televisionInstructions.items.6_title",
      "descKey": "televisionInstructions.items.6_desc",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.navy,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: ReturnButton(onTap: () => context.pop()),
        centerTitle: true,
        title: Text(
          'televisionInstructions.title'.tr(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            children: [
              _HeaderCard(subtitle: 'televisionInstructions.subtitle'.tr()),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemCount: _items.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final item = _items[index];
                    return _InstructionTile(
                      index: index + 1,
                      title: (item["titleKey"] ?? '').tr(),
                      desc: (item["descKey"] ?? '').tr(),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              AppButton(
                label: 'televisionInstructions.start'.tr(),
                onTap: () => _proceed(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _proceed(BuildContext context) async {
    await CacheService().setTelevisionInstructionsSeen(true);

    context.pushReplacement(
      TelevisionLessonRoute.name,
      extra: {"levelId": levelId, "lesson": lesson},
    );
  }
}

class _InstructionTile extends StatelessWidget {
  final int index;
  final String title;
  final String desc;

  const _InstructionTile({
    required this.index,
    required this.title,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.04),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.yellow.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                '$index',
                style: const TextStyle(
                  color: AppColors.yellow,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  desc,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.75),
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderCard extends StatelessWidget {
  final String subtitle;

  const _HeaderCard({required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.blueGrey.withOpacity(0.35),
            Colors.blueGrey.withOpacity(0.15),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.yellow.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.live_tv_rounded,
              color: AppColors.yellow,
              size: 26,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              subtitle,
              style: TextStyle(
                color: Colors.white.withOpacity(0.85),
                fontSize: 15,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
