import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mothea3_app/core/constants/app_colors.dart';
import 'package:mothea3_app/core/core_components/level_button.dart';
import 'package:mothea3_app/core/services/service_locator.dart';
import 'package:mothea3_app/core/utils/base_state.dart';
import 'package:mothea3_app/generated/locale_keys.g.dart';
import 'package:mothea3_app/modules/television/domain/entitiy/television_base_level.dart';
import 'package:mothea3_app/modules/television/presentation/blocs/television_base_levels_bloc/television_base_levels_bloc.dart';
import 'package:mothea3_app/modules/television/presentation/routes/television_level_lessons_route.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TelevisionBaseLevelsScreen extends StatelessWidget {
  const TelevisionBaseLevelsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          LocaleKeys.televisionSection.tr(),
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
          create: (context) => TelevisionBaseLevelsBloc(sl())..add(GetBaseLevelsEvent()),
          child: BlocConsumer<TelevisionBaseLevelsBloc, BaseState<List<TelevisionBaseLevel>>>(
            listener: _onLevelPressed,
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
                        'Loading levels...',
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
                final levels = state.data!;
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
                              LocaleKeys.chooseYourLevel.tr(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                letterSpacing: -0.5,
                              ),
                            ),
                            SizedBox(height: 1.h),
                            Text(
                              LocaleKeys.selectaLevelToStartYourLearningJourney.tr(),
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.6),
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: EdgeInsets.fromLTRB(6.w, 2.h, 6.w, 4.h),
                      sliver: SliverGrid(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 4.w,
                          mainAxisSpacing: 4.w,
                          childAspectRatio: 0.85,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final level = levels[index];
                            return TweenAnimationBuilder<double>(
                              tween: Tween(begin: 0, end: 1),
                              duration: Duration(milliseconds: 1000 + (index * 500)),
                              curve: Curves.easeOutCubic,
                              builder: (context, value, child) => Opacity(
                                opacity: value,
                                child: Transform.translate(
                                  offset: Offset(0, 20 * (1 - value)),
                                  child: Transform.scale(
                                    scale: 0.8 + (0.2 * value),
                                    child: child,
                                  ),
                                ),
                              ),
                              child: LevelButton(level: level  , onTap: () {
                                context.push(
                                  TelevisionLevelLessonsRoute.name,
                                  extra: level,
                                  );
                              },),
                            );
                          },
                          childCount: levels.length,
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
                      Icons.tv_outlined,
                      size: 64,
                      color: Colors.white.withOpacity(0.3),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      'No levels found',
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

  void _onLevelPressed(BuildContext context, BaseState<List<TelevisionBaseLevel>> state) {
  }
}