import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mothea3_app/core/constants/app_colors.dart';
import 'package:mothea3_app/core/core_components/audio_buttons.dart';
import 'package:mothea3_app/core/services/service_locator.dart';
import 'package:mothea3_app/core/utils/base_state.dart';
import 'package:mothea3_app/generated/locale_keys.g.dart';
import 'package:mothea3_app/modules/radio/domian/entity/radio_lesson.dart';
import 'package:mothea3_app/modules/radio/domian/entity/radio_level_lesson.dart';
import 'package:mothea3_app/modules/radio/presentation/bloc/radio_lesson_bloc/radio_lesson_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'dart:math';

class RadioLessonScreen extends StatefulWidget {
  final int levelId;
  final RadioLevelLesson lesson;

  const RadioLessonScreen({
    super.key,
    required this.levelId,
    required this.lesson,
  });

  @override
  State<RadioLessonScreen> createState() => _RadioLessonScreenState();
}

class _RadioLessonScreenState extends State<RadioLessonScreen>
    with SingleTickerProviderStateMixin {
  bool isRecording = false;
  bool isPlaying = false;
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

  void _toggleRecording() {
    setState(() {
      isRecording = !isRecording;
      if (!isRecording) mistakeIndices.clear();
    });

    if (isRecording) {
      // Simulate mistakes for UI preview
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted && isRecording) setState(() => mistakeIndices.add(3));
      });
      Future.delayed(const Duration(seconds: 4), () {
        if (mounted && isRecording) setState(() => mistakeIndices.add(10));
      });
    }
  }

  void _togglePlayback() {
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.navy,
      extendBodyBehindAppBar: true,
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
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: Colors.white, size: 20),
            onPressed: () => context.pop(),
          ),
        ),
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
          create: (context) => RadioLessonBloc(sl())..add(GetRadioLessonEvent(lessonId: widget.lesson.id, levelId: widget.levelId
          )),
          child: BlocConsumer<RadioLessonBloc, BaseState<RadioLesson>>(
            listener: (context, state) {
              
            },
            builder:(context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          }

          if (state.isError) {
            return Center(
              child: Text(
                LocaleKeys.noData.tr(),
                style: TextStyle(color: Colors.redAccent, fontSize: 18),
              ),
            );
          }

          if (state.isSuccess && state.data != null) {
            final lesson = state.data!;
            final words = lesson.paragraph.split(' ');

            return SafeArea(
              child: Padding(
                padding: EdgeInsets.fromLTRB(6.w, 3.h, 6.w, 4.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Paragraph container
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(4.w),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(20),
                          border:
                              Border.all(color: Colors.white.withOpacity(0.1)),
                        ),
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Wrap(
                            spacing: 6,
                            runSpacing: 6,
                            children: List.generate(words.length, (index) {
                              final word = words[index];
                              final isMistake = mistakeIndices.contains(index);
                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 4, vertical: 2),
                                decoration: BoxDecoration(
                                  color: isMistake
                                      ? Colors.redAccent.withOpacity(0.3)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  word,
                                  style: TextStyle(
                                    color: isMistake
                                        ? Colors.redAccent
                                        : Colors.white.withOpacity(0.9),
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

                    SizedBox(height: 3.h),
                    Center(
                      child: AudioButtons(toggleListen: _togglePlayback , toggleRecord: _toggleRecording,),
                    )
                  ],
                ),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    )
    );
  }
}

// 🔊 Sound wave widget (optional visual enhancement)
class SoundWave extends StatelessWidget {
  final bool isActive;
  final AnimationController controller;

  const SoundWave({
    super.key,
    required this.isActive,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(25, (i) {
            final height = isActive
                ? max(4.0, 10 + 20 * sin(controller.value * 2 * pi + i))
                : 10.0;
            return Container(
              width: 4,
              height: height,
              margin: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(2),
              ),
            );
          }),
        );
      },
    );
  }
}
