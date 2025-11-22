import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mothea3_app/core/constants/app_colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TelevisionRecordingScreen extends StatefulWidget {
  final String paragraph;

  const TelevisionRecordingScreen({super.key, required this.paragraph});

  @override
  State<TelevisionRecordingScreen> createState() => _TelevisionRecordingScreenState();
}

class _TelevisionRecordingScreenState extends State<TelevisionRecordingScreen> {
  CameraController? _controller;
  bool isRecording = false;
  XFile? recordedFile;
  final Set<int> mistakeIndices = {};


  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    final cameras = await availableCameras();
    final frontCamera = cameras.firstWhere((cam) => cam.lensDirection == CameraLensDirection.front);
    _controller = CameraController(frontCamera, ResolutionPreset.medium);
    await _controller!.initialize();
    if (mounted) setState(() {});
  }

  Future<void> _toggleRecording() async {
    if (_controller == null || !_controller!.value.isInitialized) return;

    if (isRecording) {
      final file = await _controller!.stopVideoRecording();
      setState(() {
        isRecording = false;
        recordedFile = file;
      });
    } else {
      await _controller!.startVideoRecording();
      setState(() => isRecording = true);
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final words = widget.paragraph.split(" ");
    if (_controller == null || !_controller!.value.isInitialized) {
      return const Scaffold(
        backgroundColor: AppColors.navy,
        body: Center(child: CircularProgressIndicator(color: Colors.white)),
      );
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: Colors.white, size: 20),
            onPressed: () => context.pop(),
          ),
        ),
        centerTitle: true,
        title: Text(
          "تسجيل الفيديو ",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: CameraPreview(_controller!),
          ),
          Positioned(
            top: 5.h,
            left: 0,
            right: 0,
            child: Container(
              height: 20.h,
              padding: EdgeInsets.all(4.w),
              margin: EdgeInsets.symmetric(horizontal: 5.w),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
                borderRadius: BorderRadius.circular(12),
              ),
              child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Wrap(
                            spacing: 2,
                            runSpacing: 0,
                            children: List.generate(words.length, (index) {
                              final word = words[index];
                              final isMistake = mistakeIndices.contains(index);
                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 4, vertical: 2),
                                decoration: BoxDecoration(
                                  color: isMistake
                                      ? Colors.redAccent.withOpacity(0.3)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  word,
                                  style: TextStyle(
                                    color: isMistake
                                        ? Colors.redAccent
                                        : Colors.white.withOpacity(0.9),
                                    fontSize: 17,
                                    height: 1.5,
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
            ),
          ),
          // زر التسجيل
          Positioned(
            bottom: 5.h,
            left: 0,
            right: 0,
            child: Center(
              child: FloatingActionButton(
                backgroundColor: isRecording ? Colors.redAccent : Colors.white,
                onPressed: _toggleRecording,
                child: Icon(
                  isRecording ? Icons.stop_rounded : Icons.fiber_manual_record,
                  color: isRecording ? Colors.white : Colors.redAccent,
                  size: 36,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
