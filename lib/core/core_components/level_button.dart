import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mothea3_app/core/constants/app_colors.dart';
import 'package:mothea3_app/generated/locale_keys.g.dart';

class LevelButton extends StatefulWidget {
  final dynamic level;
  final VoidCallback onTap;

  const LevelButton({super.key, required this.level, required this.onTap});

  @override
  State<LevelButton> createState() => _LevelButtonState();
}

class _LevelButtonState extends State<LevelButton> {
  bool _isPressed = false;

  IconData _getLevelIcon() {
    final title = widget.level.title.toLowerCase();
    if (title.contains('beginner') ||
        title.contains('basic') ||
        title.contains('1')) {
      return Icons.play_circle_outline;
    } else if (title.contains('intermediate') ||
        title.contains('medium') ||
        title.contains('2')) {
      return Icons.trending_up;
    } else if (title.contains('advanced') ||
        title.contains('expert') ||
        title.contains('3')) {
      return Icons.workspace_premium;
    } else if (title.contains('master') ||
        title.contains('pro') ||
        title.contains('4')) {
      return Icons.emoji_events;
    } else if (title.contains('music') || title.contains('song')) {
      return Icons.music_note;
    } else if (title.contains('news') || title.contains('report')) {
      return Icons.article;
    } else if (title.contains('talk') || title.contains('conversation')) {
      return Icons.forum;
    } else if (title.contains('sport')) {
      return Icons.sports_soccer;
    } else if (title.contains('weather')) {
      return Icons.wb_sunny;
    } else if (title.contains('culture') || title.contains('art')) {
      return Icons.palette;
    }
    return Icons.radio;
  }

  Color _getLevelColor() {
    // You can customize colors per index or type
    const colors = [
      Colors.green,
      Colors.blue,
      Colors.orange,
      Colors.purple,
      AppColors.yellow,
    ];
    return colors[widget.level.id % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    final levelIcon = _getLevelIcon();
    final levelColor = _getLevelColor();
    final isLocked = widget.level.locked;

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: isLocked ? 0.6 : 1.0,
      child: GestureDetector(
        onTapDown: isLocked ? null : (_) => setState(() => _isPressed = true),
        onTapUp: isLocked ? null : (_) => setState(() => _isPressed = false),
        onTapCancel: isLocked ? null : () => setState(() => _isPressed = false),
        onTap: isLocked ? null : widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          transform: Matrix4.identity()
            ..scale(isLocked ? 1.0 : (_isPressed ? 0.95 : 1.0)),
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
            border: Border.all(width: 2, color: Colors.white.withOpacity(0.1)),
            boxShadow: [
              if (!isLocked)
                BoxShadow(
                  color: levelColor.withOpacity(_isPressed ? 0.2 : 0.3),
                  blurRadius: _isPressed ? 8 : 16,
                  offset: Offset(0, _isPressed ? 2 : 4),
                ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
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
                          Colors.white.withOpacity(0.1),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      bottom: 20,
                      left: 20,
                      right: 20,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: levelColor.withOpacity(0.15),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: levelColor.withOpacity(0.3),
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: Icon(levelIcon, color: levelColor, size: 28),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          widget.level.title,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white.withOpacity(isLocked ? 0.7 : 1),
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.2,
                            height: 1.3,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: levelColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                isLocked
                                    ? LocaleKeys.Locked.tr()
                                    : LocaleKeys.start.tr(),
                                style: TextStyle(
                                  color: levelColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              if (isLocked) ...[
                                const SizedBox(width: 6),
                                Icon(Icons.lock, color: levelColor, size: 14),
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
