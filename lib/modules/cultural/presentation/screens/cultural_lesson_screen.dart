import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mothea3_app/core/constants/app_colors.dart';
import 'package:mothea3_app/core/core_components/app_button.dart';
import 'package:mothea3_app/core/core_components/app_loader.dart';
import 'package:mothea3_app/core/core_components/error_message_box.dart';
import 'package:mothea3_app/core/core_components/return_button.dart';
import 'package:mothea3_app/core/services/service_locator.dart';

import 'package:mothea3_app/modules/cultural/domain/entity/cultural_lesson.dart';
import 'package:mothea3_app/modules/cultural/domain/entity/question.dart';
import 'package:mothea3_app/modules/cultural/presentation/blocs/cultural_lesson_bloc.dart/cultural_lesson_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CulturalLessonScreen extends StatefulWidget {
  final int lessonId;

  const CulturalLessonScreen({super.key, required this.lessonId});

  @override
  State<CulturalLessonScreen> createState() => _CulturalLessonScreenState();
}

class _CulturalLessonScreenState extends State<CulturalLessonScreen> {
  final Map<int, String> userAnswers = {};

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CulturalLessonBloc(sl())
        ..add(GetLessonEvent(lessonId: widget.lessonId))
        ..add(GetLessonQuestionsEvent(lessonId: widget.lessonId)),
      child: Scaffold(
        backgroundColor: AppColors.navy,
        extendBodyBehindAppBar: true,

        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: ReturnButton(onTap: () => context.pop()),
          centerTitle: true,
          title: const Text(
            " النص الأول ",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),

        body: BlocBuilder<CulturalLessonBloc, CulturalLessonState>(
          builder: (context, state) {
            final lessonState = state.lessonState;
            final questionsState = state.questionsState;

            // Loading
            if (lessonState.isLoading || questionsState.isLoading) {
              return const AppLoader();
            }

            // Errors
            if (lessonState.isError) {
              return ErrorMessageBox(message: lessonState.errorMessage);
            }
            if (questionsState.isError) {
              return ErrorMessageBox(message: questionsState.errorMessage);
            }

            if (!lessonState.isSuccess || lessonState.data == null) {
              return const SizedBox.shrink();
            }

            final CulturalLesson lesson = lessonState.data!;
            final List<Question> questions = questionsState.data ?? [];
            final words = lesson.paragraph.split(' ');

            // ==========================
            // Layout FIX — no overflow
            // ==========================
            return SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                        horizontal: 5.w,
                        vertical: 2.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ======================
                          // Paragraph
                          // ======================
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(4.w),
                            decoration: BoxDecoration(
                              color: AppColors.white.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: AppColors.white.withOpacity(0.1),
                              ),
                            ),
                            child: Wrap(
                              spacing: 6,
                              runSpacing: 6,
                              children: words.map((w) {
                                return Text(
                                  w,
                                  style: TextStyle(
                                    color: AppColors.white.withOpacity(0.9),
                                    fontSize: 17,
                                  ),
                                );
                              }).toList(),
                            ),
                          ),

                          SizedBox(height: 3.h),

                          // ======================
                          // Questions
                          // ======================
                          ...List.generate(questions.length, (index) {
                            final q = questions[index];

                            return Container(
                              margin: EdgeInsets.only(bottom: 2.h),
                              padding: EdgeInsets.all(3.w),
                              decoration: BoxDecoration(
                                color: AppColors.white.withOpacity(0.05),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: AppColors.white.withOpacity(0.15),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    q.question,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 1.h),

                                  ...q.options.entries.map((opt) {
                                    final selected =
                                        userAnswers[index] == opt.key;

                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          userAnswers[index] = opt.key;
                                        });
                                      },
                                      child: Container(
                                        width: double
                                            .infinity, 
                                        margin: EdgeInsets.only(bottom: 1.h),
                                        padding: EdgeInsets.all(3.w),
                                        decoration: BoxDecoration(
                                          color: selected
                                              ? Colors.pinkAccent.withOpacity(
                                                  0.7,
                                                )
                                              : Colors.white.withOpacity(0.05),
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          border: Border.all(
                                            color: selected
                                                ? Colors.pinkAccent
                                                : Colors.white.withOpacity(
                                                    0.15,
                                                  ),
                                          ),
                                        ),
                                        child: Text(
                                          "${opt.key}) ${opt.value}",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                ],
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),

                  // ==========================
                  // FIXED SUBMIT BUTTON
                  // ==========================
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.w,
                      vertical: 1.5.h,
                    ),
                    color: AppColors.navy,
                    child: AppButton(
                      label: "ارسال",
                      onTap: () {
                        debugPrint("USER ANSWERS = $userAnswers");
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
