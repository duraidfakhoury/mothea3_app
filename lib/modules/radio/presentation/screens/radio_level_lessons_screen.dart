import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mothea3_app/core/constants/app_colors.dart';
import 'package:mothea3_app/core/core_components/app_loader.dart';
import 'package:mothea3_app/core/core_components/error_message_box.dart';
import 'package:mothea3_app/core/core_components/lesson_card.dart';
import 'package:mothea3_app/core/core_components/return_button.dart';
import 'package:mothea3_app/core/services/service_locator.dart';
import 'package:mothea3_app/core/utils/base_state.dart';
import 'package:mothea3_app/generated/locale_keys.g.dart';
import 'package:mothea3_app/modules/radio/domian/entity/radio_base_level.dart';
import 'package:mothea3_app/modules/radio/domian/entity/radio_level_lesson.dart';
import 'package:mothea3_app/modules/radio/presentation/bloc/radio_level_lessons_bloc/radio_level_lessons_bloc.dart';
import 'package:mothea3_app/modules/radio/presentation/routes/radio_lesson_route.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class RadioLevelLessonsScreen extends StatelessWidget {
  final RadioBaseLevel level;

  const RadioLevelLessonsScreen({super.key, required this.level});

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
          level.title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),
      body: SafeArea(
        child: BlocProvider(
          create: (context) =>
              RadioLevelLessonsBloc(sl())
                ..add(GetLevelLessonsEvent(levelId: level.id)),
          child:
              BlocConsumer<
                RadioLevelLessonsBloc,
                BaseState<List<RadioLevelLesson>>
              >(
                listener: _onLessonPressed,
                builder: (context, state) {
                  if (state.isLoading) {
                    return AppLoader();
                  }
                  if (state.isError) {
                    return ErrorMessageBox(message: state.errorMessage);
                  }
                  if (state.isSuccess && state.data != null) {
                    final lessons = state.data!;
                    return CustomScrollView(
                      physics: const BouncingScrollPhysics(),
                      slivers: [
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(6.w, 3.h, 6.w, 2.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  LocaleKeys.lessons.tr(),
                                  style: TextStyle(
                                    color: AppColors.white,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: -0.5,
                                  ),
                                ),
                                SizedBox(height: 1.h),
                                Text(
                                  LocaleKeys.selectaLessonToStartLearning.tr(),
                                  style: TextStyle(
                                    color: AppColors.white.withOpacity(0.6),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: 2.h),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 4.w,
                                    vertical: 2.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.white.withOpacity(0.05),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: AppColors.white.withOpacity(0.1),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(2.w),
                                        decoration: BoxDecoration(
                                          color: AppColors.yellow.withOpacity(
                                            0.2,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.book_outlined,
                                          color: AppColors.yellow,
                                          size: 24,
                                        ),
                                      ),
                                      SizedBox(width: 3.w),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              level.title,
                                              style: TextStyle(
                                                color: AppColors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              '${lessons.length - 5} ${LocaleKeys.lessonsToCompleteTheLevel.tr()}${LocaleKeys.withh.tr()} 5 ${LocaleKeys.additionalLessons.tr()}',
                                              style: TextStyle(
                                                color: AppColors.white.withOpacity(
                                                  0.6,
                                                ),
                                                fontSize: 13,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SliverPadding(
                          padding: EdgeInsets.fromLTRB(6.w, 2.h, 6.w, 4.h),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate((
                              context,
                              index,
                            ) {
                              final lesson = lessons[index];
                              return TweenAnimationBuilder<double>(
                                tween: Tween(begin: 0, end: 1),
                                duration: Duration(
                                  milliseconds: 1000 + (index * 500),
                                ),
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
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: 2.h),
                                  child: LessonCard(
                                    icon: Icons.radio_outlined,
                                    lesson: lesson,
                                    index: index,
                                    onTap: () {
                                      context.push(
                                        RadioLessonRoute.name,

                                        extra: {
                                          "levelId": level.id,
                                          "lesson": lesson,
                                        },
                                      );
                                    },
                                  ),
                                ),
                              );
                            }, childCount: lessons.length),
                          ),
                        ),
                      ],
                    );
                  }

                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.library_books_outlined,
                          size: 64,
                          color: AppColors.white.withOpacity(0.3),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          LocaleKeys.noData.tr(),
                          style: TextStyle(
                            color: AppColors.white.withOpacity(0.7),
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
        ),
      ),
    );
  }

  void _onLessonPressed(
    BuildContext context,
    BaseState<List<RadioLevelLesson>> state,
  ) {
    // Handle navigation or actions when a lesson is pressed
  }
}
