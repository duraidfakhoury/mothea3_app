import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mothea3_app/core/constants/app_colors.dart';
import 'package:mothea3_app/core/core_components/app_loader.dart';
import 'package:mothea3_app/core/enums/acadimic_status.dart';
import 'package:mothea3_app/core/services/service_locator.dart';
import 'package:mothea3_app/core/utils/base_state.dart';
import 'package:mothea3_app/core/utils/island_painter.dart';
import 'package:mothea3_app/generated/locale_keys.g.dart';
import 'package:mothea3_app/modules/cultural/presentation/routes/cultural_base_levels_route.dart';
import 'package:mothea3_app/modules/home/presentation/blocs/user_bloc/user_bloc.dart';
import 'package:mothea3_app/modules/home/presentation/components/island_buble.dart';
import 'package:mothea3_app/modules/home/presentation/components/islands_loader.dart';
import 'package:mothea3_app/modules/home/presentation/components/session_option.dart';
import 'package:mothea3_app/modules/home/presentation/routes/contact_us_route.dart';
import 'package:mothea3_app/modules/home/presentation/routes/knowledge_base_route.dart';
import 'package:mothea3_app/modules/radio/presentation/routes/radio_fields_route.dart';
import 'package:mothea3_app/modules/auth/domain/entity/profile.dart'; // for enum
import 'package:mothea3_app/modules/television/presentation/routes/television_fields_route.dart';
import 'package:mothea3_app/modules/television/presentation/routes/television_pre_cond_route.dart';
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
  }

  @override
  void dispose() {
    _tc.removeListener(_onTransformChanged);
    _tc.dispose();
    super.dispose();
  }

  void _onTransformChanged() => setState(() {});

  double get scale => _tc.value.getMaxScaleOnAxis();

  List<String> _routesForUser(Profile user) {
    switch (user.acadamicStatus) {
      case AcadimicStatus.beginner:
        return [
          TelevisionPreCondRoute.name,
          RadioFieldsRoute.name,
          CulturalBaseLevelsRoute.name,
          "",
          "",
        ];

      case AcadimicStatus.intermediate:
        return [
          TelevisionFieldsRoute.name,
          RadioFieldsRoute.name,
          CulturalBaseLevelsRoute.name,
          "",
          "",
        ];

      case AcadimicStatus.advanced:
        return [
          TelevisionFieldsRoute.name,
          RadioFieldsRoute.name,
          CulturalBaseLevelsRoute.name,
          "",
          "",
        ];
    }
  }

  Future<void> _initIslands(List<String> routes) async {
    final userIsBeginner = routes.first == TelevisionPreCondRoute.name;
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
      routes: routes,
      isLocked: (index) => userIsBeginner && index == 0,
    );

    setState(() => _islands = islands);
  }

  List<Widget> _buildIslandBubbles() {
    return _islands.map((island) {
      return IslandBubble(
        island: island,
        isSelected: selected == island,
        onTap: () {
          setState(() => selected = island);
          if (island.route.isNotEmpty) {
            context.push(island.route);
          }
        },
      );
    }).toList();
  }

  Widget _buildHomeView() {
    final canvasBounds = _islands.isEmpty
        ? const Size(1200, 800)
        : _islands
              .map((i) => i.bounds)
              .reduce((a, b) => a.expandToInclude(b))
              .inflate(100)
              .size;

    return Stack(
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                color: AppColors.navy.withOpacity(0.1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${LocaleKeys.mothea3.tr()} .",
                          style: const TextStyle(
                            color: AppColors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          LocaleKeys.theArtOfPublicSpeaking.tr(),
                          style: const TextStyle(
                            color: AppColors.greyAccent,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const CircleAvatar(
                      backgroundColor: AppColors.white,
                      radius: 20,
                      child: Icon(Icons.search, color: AppColors.black),
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
              child: _bottomBar(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _bottomBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      color: AppColors.navy.withOpacity(0.1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () => context.push(KnowledgeBaseRoute.name),
                icon: Container(
                  width: 44,
                  height: 44,
                  decoration: const BoxDecoration(
                    color: AppColors.yellow,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.psychology, color: AppColors.white),
                ),
                padding: EdgeInsets.zero,
                splashRadius: 26,
              ),
              const SizedBox(height: 6),
              Text(
                LocaleKeys.knowledgeBank.tr(),
                style: const TextStyle(color: AppColors.white, fontSize: 12),
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
                      SessionOption(
                        icon: Icons.tv,
                        title: LocaleKeys.televisionSection.tr(),
                        locked: _islands.first.locked,
                        onTap: () {
                          Navigator.pop(context);

                          context.push(_islands.first.route);
                        },
                      ),
                      SizedBox(height: 0.7.h),
                      SessionOption(
                        icon: Icons.radio,
                        title: LocaleKeys.radioSection.tr(),

                        onTap: () {
                          Navigator.pop(context);
                          context.push(RadioFieldsRoute.name);
                        },
                      ),
                      SizedBox(height: 0.7.h),
                      SessionOption(
                        icon: Icons.mic,
                        title: LocaleKeys.culturalSectoin.tr(),
                        onTap: () {
                          Navigator.pop(context);
                          context.push(CulturalBaseLevelsRoute.name);
                        },
                      ),
                      SizedBox(height: 0.7.h),
                      SessionOption(
                        icon: Icons.person,
                        title: LocaleKeys.profile.tr(),
                        onTap: () {
                          Navigator.pop(context);
                          //context.push('/session/public-speaking');
                        },
                      ),
                      SizedBox(height: 0.7.h),
                      SessionOption(
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

          /// Contact us
          IconButton(
            onPressed: () => context.push(ContactUsRoute.name),
            icon: Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                color: AppColors.yellow,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.call, color: AppColors.white),
            ),
            padding: EdgeInsets.zero,
            splashRadius: 26,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc(sl())..add(GetUserEvent()),
      child: BlocBuilder<UserBloc, BaseState<Profile>>(
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
                    'Loading ',
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
            return const Scaffold(
              body: Center(child: Text("Error loading user")),
            );
          }

          if (state.isSuccess) {
            final user = state.data!;

            final routes = _routesForUser(user);

            if (_islands.isEmpty) {
              _initIslands(routes);
              return const Scaffold(body: AppLoader());
            }
          }

          return Scaffold(body: _buildHomeView());
        },
      ),
    );
  }
}
