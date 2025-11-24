import 'package:flutter/material.dart';
import 'islands_loader.dart';

class IslandBubble extends StatelessWidget {
  final Island island;
  final bool isSelected;
  final VoidCallback onTap;

  const IslandBubble({
    super.key,
    required this.island,
    required this.isSelected,
    required this.onTap,
  });

  static const double _bubbleHPad = 16;
  static const double _bubbleVPad = 2;
  static const double _bubbleRadius = 12;

  static const TextStyle _bubbleTextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Color(0xFFFFFFFF),
  );

  double _textWidth(String text, TextStyle style) {
    final tp = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
      maxLines: 1,
    )..layout();
    return tp.width;
  }

  @override
  Widget build(BuildContext context) {
    final txtW = _textWidth(island.name, _bubbleTextStyle);
    final bubbleW = island.locked ? txtW + _bubbleHPad * 5 :txtW + _bubbleHPad * 3.8 ;
    const bubbleH = 30.0;

    final left = island.bounds.center.dx-50;
    final top = island.bounds.center.dy;

    return Positioned(
      left: left,
      top: top,
      width: bubbleW,
      height: bubbleH,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: _bubbleHPad, vertical: _bubbleVPad),
          decoration: BoxDecoration(
            color: isSelected
              ? island.color.withOpacity(0.75)
              : island.color.withOpacity(0.95),
            borderRadius: BorderRadius.circular(_bubbleRadius),
            border: Border.all(color: island.color.withValues(alpha: 0.5)),
            boxShadow: [
              BoxShadow(
                blurRadius: 8,
                offset: const Offset(0, 2),
                color: Color(0xFF000000).withOpacity(0.25),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Row(
            children: [
              Text(island.name, style: _bubbleTextStyle),
              if (island.locked)
              const Positioned(
                top: 0,
                right: 0,
                child: Icon(Icons.lock, color: Colors.white, size: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
