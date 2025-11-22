import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mothea3_app/core/constants/app_colors.dart';
import 'package:mothea3_app/core/core_components/lesson_card.dart';
import 'package:mothea3_app/core/services/service_locator.dart';
import 'package:mothea3_app/core/utils/base_state.dart';
import 'package:mothea3_app/generated/locale_keys.g.dart';
import 'package:mothea3_app/modules/television/domain/entitiy/television_base_level.dart';
import 'package:mothea3_app/modules/television/domain/entitiy/television_level_lesson.dart';
import 'package:mothea3_app/modules/television/presentation/blocs/television_level_lessons_bloc/television_level_lessons_bloc.dart';
import 'package:mothea3_app/modules/television/presentation/routes/television_lesson_route.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TelevisionLevelLessonsScreen extends StatelessWidget {
  final TelevisionBaseLevel level;
  
  const TelevisionLevelLessonsScreen({
    super.key,
    required this.level,
  });

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
          create: (context) => TelevisionLevelLessonsBloc(sl())..add(GetLevelLessonsEvent(levelId: level.id)),
          child: BlocConsumer<TelevisionLevelLessonsBloc, BaseState<List<TelevisionLevelLesson>>>(
            listener: _onLessonPressed,
            builder: (context, state) {
              if (state.isLoading) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(AppColors.yellow),
                        strokeWidth: 3,
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        'Loading lessons...',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                );
              }

              if (state.isError) {
                return Center(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 6.w),
                    padding: EdgeInsets.all(4.w),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.red.withOpacity(0.3)),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.error_outline, color: Colors.red[300], size: 48),
                        SizedBox(height: 2.h),
                        Text(
                          state.errorMessage,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
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
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                letterSpacing: -0.5,
                              ),
                            ),
                            SizedBox(height: 1.h),
                            Text(
                              LocaleKeys.selectaLessonToStartLearning.tr(),
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.6),
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.05),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.1),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(2.w),
                                    decoration: BoxDecoration(
                                      color: AppColors.yellow.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(12),
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
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          level.title,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          '${lessons.length-5} ${LocaleKeys.lessonsToCompleteTheLevel.tr()}${LocaleKeys.withh.tr()} 5 ${LocaleKeys.additionalLessons.tr()}',
                                          style: TextStyle(
                                            color: Colors.white.withOpacity(0.6),
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
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final lesson = lessons[index];
                            return TweenAnimationBuilder<double>(
                              tween: Tween(begin: 0, end: 1),
                              duration: Duration(milliseconds: 1000 + (index * 500)),
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
                                  icon: Icons.tv_outlined,
                                  lesson: lesson,
                                  index: index,
                                  onTap:  () {
                context.push(
                  TelevisionLessonRoute.name,
                  extra: 
                  {"levelId" : level.id,
                    "lesson" :lesson
                   },
                );
              }
                                ),
                              ),
                            );
                          },
                          childCount: lessons.length,
                        ),
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
                      color: Colors.white.withOpacity(0.3),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      LocaleKeys.noData.tr(),
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
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

  void _onLessonPressed(BuildContext context, BaseState<List<TelevisionLevelLesson>> state) {
    // Handle navigation or actions when a lesson is pressed
  }
}