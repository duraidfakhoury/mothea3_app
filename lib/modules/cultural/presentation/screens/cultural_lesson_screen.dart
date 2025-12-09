import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mothea3_app/core/constants/app_colors.dart';
import 'package:mothea3_app/core/core_components/app_loader.dart';
import 'package:mothea3_app/core/core_components/error_message_box.dart';
import 'package:mothea3_app/core/core_components/return_button.dart';
import 'package:mothea3_app/core/services/service_locator.dart';
import 'package:mothea3_app/core/utils/base_state.dart';
import 'package:mothea3_app/generated/locale_keys.g.dart';
import 'package:mothea3_app/modules/television/domain/entitiy/television_lesson.dart';
import 'package:mothea3_app/modules/television/domain/entitiy/television_level_lesson.dart';
import 'package:mothea3_app/modules/television/presentation/blocs/television_lesson_bloc/television_lesson_bloc.dart';
import 'package:mothea3_app/modules/television/presentation/routes/television_recording_route.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CulturalLessonScreen extends StatefulWidget {
  final int levelId;
  final TelevisionLevelLesson lesson;

  const CulturalLessonScreen({
    super.key,
    required this.levelId,
    required this.lesson,
  });

  @override
  State<CulturalLessonScreen> createState() => _CulturalLessonScreenState();
}

class _CulturalLessonScreenState extends State<CulturalLessonScreen>
    with SingleTickerProviderStateMixin {
  final Set<int> mistakeIndices = {};

  late AnimationController _waveController;

  @override
  void initState() {
    super.initState();

    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _waveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.navy,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: ReturnButton(onTap: () => context.pop(),),
        centerTitle: true,
        title: Text(
          widget.lesson.title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) => TelevisionLessonBloc(sl())
          ..add(
            GetTelevisionLessonEvent(
              lessonId: widget.lesson.id,
              levelId: widget.levelId,
            ),
          ),
        child: BlocConsumer<TelevisionLessonBloc, BaseState<TelevisionLesson>>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state.isLoading) {
              return AppLoader();
            }

            if (state.isError) {
              return ErrorMessageBox(message: state.errorMessage);
            }

            if (state.isSuccess && state.data != null) {
              final lesson = state.data!;
              final words = lesson.paragraph.split(' ');

              return SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(5.w),
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(4.w),
                          decoration: BoxDecoration(
                            color: AppColors.white.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: AppColors.white.withOpacity(0.1),
                            ),
                          ),
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Wrap(
                              spacing: 6,
                              runSpacing: 6,
                              children: List.generate(words.length, (index) {
                                final word = words[index];
                                return AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 4,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    word,
                                    style: TextStyle(
                                      color: AppColors.white.withOpacity(0.9),
                                      fontSize: 17,
                                      height: 1.5,
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pinkAccent,
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 2.h,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          context.push(
                            TelevisionRecordingRoute.name,
                            extra: lesson.paragraph,
                          );
                        },
                        icon: const Icon(
                          Icons.videocam_rounded,
                          color: AppColors.white,
                        ),
                        label:  Text(
                          LocaleKeys.startRecordingVedio.tr(),
                          style: TextStyle(color: AppColors.white, fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
