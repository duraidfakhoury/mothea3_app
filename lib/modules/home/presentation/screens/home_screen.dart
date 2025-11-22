import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mothea3_app/core/constants/app_colors.dart';
import 'package:mothea3_app/core/utils/island_painter.dart';
import 'package:mothea3_app/generated/locale_keys.g.dart';
import 'package:mothea3_app/modules/home/presentation/components/island_buble.dart';
import 'package:mothea3_app/modules/home/presentation/components/islands_loader.dart';
import 'package:mothea3_app/modules/home/presentation/routes/contact_us_route.dart';
import 'package:mothea3_app/modules/home/presentation/routes/knowledge_base_route.dart';
import 'package:mothea3_app/modules/radio/presentation/routes/radio_base_levels_route.dart';
import 'package:mothea3_app/modules/television/presentation/routes/television_base_levels_route.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TransformationController _tc = TransformationController();
  List<Island> _islands = [];
  Island? selected;

  @override
  void initState() {
    super.initState();
    _tc.addListener(_onTransformChanged);
    _initIslands();
  }

  void _onTransformChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    _tc.removeListener(_onTransformChanged);
    _tc.dispose();
    super.dispose();
  }

  Future<void> _initIslands() async {
    final islands = await loadIslands(
      pngAssets: const [
        'assets/islands/island_1.png',
        'assets/islands/island_2.png',
        'assets/islands/island_3.png',
        'assets/islands/island_4.png',
        'assets/islands/island_5.png',
      ],
      offsets: const [
        Offset(90, 100),
        Offset(0, 230),
        Offset(-30, 360),
        Offset(45, 450),
        Offset(190, 285),
      ],
      uniformScale: 1,
      names: [
        LocaleKeys.televisionSection.tr(),
        LocaleKeys.radioSection.tr(),
        LocaleKeys.culturalSectoin.tr(),
        LocaleKeys.profile.tr(),
        LocaleKeys.settings.tr(),
      ],
      routes: [
        TelevisionBaseLevelsRoute.name,
        RadioBaseLevelsRoute.name,
        "",
        "",
        "",
      ]
    );

    setState(() => _islands = islands);
  }

  double get scale => _tc.value.getMaxScaleOnAxis();

  List<Widget> _buildIslandBubbles() {
    return _islands.map((island) {
      return IslandBubble(
        island: island,
        isSelected: selected == island,
        onTap: () {
          setState(() => selected = island);
          if (island.route.isNotEmpty && island.route != 'no route') {
            context.push(island.route);
          }
        },
      );
    }).toList();
  }

// void _onTapDown(TapDownDetails d) {
//   if (_islands.isEmpty) return;
//   final box = context.findRenderObject() as RenderBox;
//   final local = box.globalToLocal(d.globalPosition);
//   final inv = Matrix4.inverted(_tc.value);
//   final v = Vector3(local.dx, local.dy, 0)..applyMatrix4(inv);
//   final p = Offset(v.x, v.y);

//   for (final island in _islands.reversed) {
//     if (island.bounds.contains(p)) {
//       setState(() => selected = island);

//       // ✅ Navigate if this island has a route
//       if (island.route.isNotEmpty) {
//                   context.push(island.route);

//       }
//       return;
//     }
//   }

//   setState(() => selected = null);
// }


  @override
  Widget build(BuildContext context) {
    final canvasBounds = _islands.isEmpty
        ? const Size(1200, 800)
        : _islands
            .map((i) => i.bounds)
            .reduce((a, b) => a.expandToInclude(b))
            .inflate(100)
            .size;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
              InteractiveViewer(
                transformationController: _tc,
                minScale: 0.4,
                maxScale: 5.0,
                boundaryMargin: const EdgeInsets.all(300),
                constrained: false,
                child: Stack(
                  children: [
                    CustomPaint(
                      size: canvasBounds,
                      painter: IslandPainter(_islands, highlight: selected),
                    ),
                    if (scale >= 1.0) ..._buildIslandBubbles(),
                  ],
                ),
              ),
            
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    color: AppColors.navy.withOpacity(0.1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${LocaleKeys.mothea3.tr()} .",
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 2,),
                            Text(
                              LocaleKeys.theArtOfPublicSpeaking.tr(),
                              style: TextStyle(
                                color: AppColors.greyAccent,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        CircleAvatar(
                          backgroundColor: AppColors.white,
                          radius: 20,
                          child: Icon(Icons.search, color: AppColors.black,fontWeight: FontWeight.bold,),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    color: AppColors.navy.withOpacity(0.1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children:[
                            IconButton(
  onPressed: () {
    context.push(KnowledgeBaseRoute.name);
  },
  icon: Container(
    width: 44, // diameter = 2 * radius
    height: 44,
    decoration: BoxDecoration(
      color: AppColors.yellow,
      shape: BoxShape.circle,
    ),
    child: const Icon(
      Icons.psychology,
      color: AppColors.white,
    ),
  ),
  padding: EdgeInsets.zero, // removes default padding
  splashRadius: 26, // similar to CircleAvatar tap radius
),

                            SizedBox(height: 6),
                            Text(
                              LocaleKeys.knowledgeBank.tr(),
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: AppColors.white, fontSize: 12),
                            ),
                          ],
                        ),

ElevatedButton.icon(
  onPressed: () {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.navy.withOpacity(0.95),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 50,
                height: 5,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            
             SizedBox(height: 1.5.h),
            _sessionOption(
              icon: Icons.tv,
              title: LocaleKeys.televisionSection.tr(),
              onTap: () {
                Navigator.pop(context);
                 context.push(TelevisionBaseLevelsRoute.name);
              },
            ),
             SizedBox(height: 0.7.h),
            _sessionOption(
              icon: Icons.radio,
              title: LocaleKeys.radioSection.tr(),
              onTap: () {
                Navigator.pop(context);
                context.push(RadioBaseLevelsRoute.name);
              },
            ),
             SizedBox(height: 0.7.h),

            _sessionOption(
              icon: Icons.mic,
              title: LocaleKeys.culturalSectoin.tr(),
              onTap: () {
                Navigator.pop(context);
                // context.push('/session/radio');
              },
            ),
             SizedBox(height: 0.7.h),


            _sessionOption(
              icon: Icons.person,
              title: LocaleKeys.profile.tr(),
              onTap: () {
                Navigator.pop(context);
                // context.push('/session/public-speaking');
              },
            ),
             SizedBox(height: 0.7.h),

            _sessionOption(
              icon: Icons.settings,
              title: LocaleKeys.settings.tr(),
              onTap: () {
                Navigator.pop(context);
              },
            ),
             SizedBox(height: 1.h),

          ],
        ),
      ),
    );
  },
  icon: const Icon(Icons.bolt, color: AppColors.white),
  label: Text(
    LocaleKeys.smartSession.tr(),
    style: TextStyle(
      color: AppColors.white,
      fontWeight: FontWeight.bold,
    ),
  ),
  style: ElevatedButton.styleFrom(
    backgroundColor: AppColors.yellow,
    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
  ),
),
                        IconButton(
  onPressed: () {
    context.push(ContactUsRoute.name);
  },
  icon: Container(
    width: 44, // diameter = 2 * radius
    height: 44,
    decoration: BoxDecoration(
      color: AppColors.yellow,
      shape: BoxShape.circle,
    ),
    child: const Icon(
      Icons.call,
      color: AppColors.white,
    ),
  ),
  padding: EdgeInsets.zero, // removes default padding
  splashRadius: 26, // similar to CircleAvatar tap radius
),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _sessionOption({
  required IconData icon,
  required String title,
  required VoidCallback onTap,
}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(12),
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.navyAccent.withOpacity(0.4),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.white)
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.yellow, size: 26),
          const SizedBox(width: 12),
          Text(
            title,
            style: const TextStyle(
              color: AppColors.greyAccent,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    ),
  );
}

