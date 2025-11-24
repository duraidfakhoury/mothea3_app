import 'dart:ui' as ui;
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';

class SubProject {
  final String id;
  final Offset position;
  final String title;
  const SubProject({
    required this.id,
    required this.position,
    required this.title,
  });
}

class Island {
  final bool locked ; 
  final String id;
  final String name;
  final ui.Image image; 
  final Rect bounds;
  final Color color; 
  final String route;
  final List<SubProject> subs;
  const Island( {
    required this.locked,
    required this.route,
    required this.id,
    required this.name,
    required this.color,
    required this.image,
    required this.bounds,
    this.subs = const [],
  });
}

Future<ui.Image> _imageFromPng(String assetPath) async {
  final data = await rootBundle.load(assetPath);
  final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
  final frame = await codec.getNextFrame();
  return frame.image;
}

Future<List<Island>> loadIslands({
  required List<String> pngAssets,
  required List<Offset> offsets, 
  double uniformScale = 1.0,
  List<String>? names,
  List<String>? routes,
  bool Function(int index)? isLocked,
}) async {
  assert(pngAssets.length == offsets.length, 'assets/offsets length mismatch');
  final out = <Island>[];

  for (int i = 0; i < pngAssets.length; i++) {
    final img = await _imageFromPng(pngAssets[i]);

    final width = img.width * uniformScale;
    final height = img.height * uniformScale;
    final offset = offsets[i];
    final rect = Rect.fromLTWH(offset.dx, offset.dy, width, height);



    final color = await getAverageColor(img);



    final enhancedColor = enhanceColor(color);
    

    out.add(Island(
      locked: isLocked?.call(i) ?? false, // 🔥 Add locked  
      id: 'island_${i + 1}',
      name: names != null && i < names.length ? names[i] : 'Island ${i + 1}',
      image: img,
      bounds: rect,
      color: enhancedColor,
      subs: const [],
      route: routes != null && i < routes.length ? routes[i] : 'no route'
    ));
  }

  return out;
}

Color enhanceColor(Color color, {double saturation = 5.0, double brightness = 3.0}) {
  final hsl = HSLColor.fromColor(color);

  final saturated = hsl
      .withSaturation((hsl.saturation * saturation).clamp(0.0, 1.0))
      .withLightness((hsl.lightness * brightness).clamp(0.0, 1.0));

  return saturated.toColor();
}



Future<Color> getAverageColor(ui.Image image, {int step = 4}) async {
  final byteData = await image.toByteData(format: ui.ImageByteFormat.rawRgba);
  if (byteData == null) return Colors.grey;
  final bytes = byteData.buffer.asUint8List();
  int r = 0, g = 0, b = 0, count = 0;

  for (int i = 0; i < bytes.length; i += 4 * step) {
    final alpha = bytes[i + 3];
    if (alpha < 40) continue; 
    r += bytes[i];
    g += bytes[i + 1];
    b += bytes[i + 2];
    count++;
  }

  if (count == 0) return Colors.grey;
  return Color.fromARGB(255, (r ~/ count), (g ~/ count), (b ~/ count));
}
