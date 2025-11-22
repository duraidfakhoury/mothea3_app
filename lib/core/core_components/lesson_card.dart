import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mothea3_app/core/constants/app_colors.dart';
import 'package:mothea3_app/generated/locale_keys.g.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LessonCard extends StatefulWidget {
  final dynamic lesson;
  final int index;
  final VoidCallback onTap ; 
  final IconData icon;

  const LessonCard({
    super.key,
    required this.lesson,
    required this.index,
    required this.onTap,
    required this.icon
  });

  @override
  State<LessonCard> createState() => _LessonCardState();
}

class _LessonCardState extends State<LessonCard> {
  bool _isPressed = false;

  IconData _getLessonIcon() {
    final title = widget.lesson.title.toLowerCase();
    if (title.contains('intro') || title.contains('start')) {
      return Icons.lightbulb_outline;
    } else if (title.contains('music')) {
      return Icons.music_note;
    } else if (title.contains('news')) {
      return Icons.article;
    } else if (title.contains('talk')) {
      return Icons.record_voice_over;
    } else if (title.contains('practice') || title.contains('exercise')) {
      return Icons.school;
    }
    return widget.icon;
  }

  Color _getLessonColor() {
    // You can customize colors per index or type
    const colors = [
      Colors.green,
      Colors.blue,
      Colors.orange,
      Colors.purple,
      AppColors.yellow,
    ];
    return colors[widget.index % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    final lessonIcon = _getLessonIcon();
    final lessonColor = _getLessonColor();
    final status = widget.lesson.status as String;
    final isLocked = status == "locked";
    final isCompleted = status == "completed";

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: isLocked ? 0.6 : 1.0,
      child: GestureDetector(
        onTapDown: isLocked ? null : (_) => setState(() => _isPressed = true),
        onTapUp: isLocked ? null : (_) => setState(() => _isPressed = false),
        onTapCancel: isLocked ? null : () => setState(() => _isPressed = false),
        onTap: isLocked
            ? null
            : widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          transform: Matrix4.identity()..scale(isLocked ? 1.0 : (_isPressed ? 0.97 : 1.0)),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.navyAccent.withOpacity(isLocked ? 0.5 : 0.8),
                AppColors.navyAccent.withOpacity(isLocked ? 0.6 : 1.0),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              width: 2,
              color: Colors.white.withOpacity(0.1),
            ),
            boxShadow: [
              if (!isLocked)
                BoxShadow(
                  color: lessonColor.withOpacity(_isPressed ? 0.2 : 0.3),
                  blurRadius: _isPressed ? 8 : 16,
                  offset: Offset(0, _isPressed ? 2 : 4),
                ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                // light overlay
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: 60,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white.withOpacity(0.08),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),

                // Main content
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18 , vertical: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            color: lessonColor.withOpacity(0.15),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: lessonColor.withOpacity(0.3),
                              width: 2,
                            ),
                          ),
                          child: Icon(
                            lessonIcon,
                            color: lessonColor,
                            size: 20,
                          ),
                        ),
                         SizedBox(height: 0.4.h),
                        Text(
                          widget.lesson.title,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white.withOpacity(isLocked ? 0.7 : 0.9),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                         SizedBox(height: 0.4.h),
                        Container(
                          padding: isLocked? EdgeInsets.symmetric(horizontal: 12, vertical: 4) : EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                          decoration: BoxDecoration(
                            color: lessonColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                isLocked ? LocaleKeys.Locked.tr() : (isCompleted ?LocaleKeys.completed.tr() : LocaleKeys.start.tr()),
                                style: TextStyle(
                                  color: lessonColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              if (isLocked) ...[
                                const SizedBox(width: 6),
                                Icon(
                                  Icons.lock,
                                  color: lessonColor,
                                  size: 14,
                                ),
                              ],
                              if (isCompleted) ...[
                                const SizedBox(width: 6),
                                Icon(
                                  Icons.check_circle,
                                  color: Colors.greenAccent,
                                  size: 14,
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
