import 'package:flutter/material.dart' hide Colors;
import 'package:mothea3_app/modules/home/presentation/components/islands_loader.dart';

class IslandPainter extends CustomPainter {
  final List<Island> islands;
  final Island? highlight;
  IslandPainter(this.islands, {this.highlight});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    for (final island in islands) {
      final rect = island.bounds;
      canvas.drawImageRect(
        island.image,
        Rect.fromLTWH(0, 0, island.image.width.toDouble(), island.image.height.toDouble()),
        rect,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant IslandPainter old) =>
      old.islands != islands || old.highlight != highlight;
}
