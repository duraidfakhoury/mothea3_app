import 'dart:math';
import 'package:flutter/material.dart';

class AudioButtons extends StatefulWidget {
  final VoidCallback toggleRecord ;
  final VoidCallback toggleListen ;

  const AudioButtons({super.key ,required this.toggleListen , required this.toggleRecord  });

  @override
  State<AudioButtons> createState() => _AudioButtonsState();
}

class _AudioButtonsState extends State<AudioButtons>
    with TickerProviderStateMixin {
  late AnimationController _recordController;
  late AnimationController _listenController;

  bool _isRecording = false;
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    _recordController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat();
    _listenController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat();
  }

  @override
  void dispose() {
    _recordController.dispose();
    _listenController.dispose();
    super.dispose();
  }

  void _toggleRecord() {
    setState(() {
      
      _isRecording = !_isRecording;
      if (_isRecording) {
        widget.toggleRecord;
        _recordController.repeat();
      } else {
        _recordController.stop();
      }
    });
  }

  void _toggleListen() {
    setState(() {
      _isListening = !_isListening;
      if (_isListening) {
        widget.toggleListen;
        _listenController.repeat();
      } else {
        _listenController.stop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildAudioButton(
          isActive: _isRecording,
          controller: _recordController,
          color: Colors.redAccent,
          icon: Icons.mic,
          label: "Record",
          onTap: _toggleRecord,
        ),
        const SizedBox(height: 24),
        _buildAudioButton(
          isActive: _isListening,
          controller: _listenController,
          color: Colors.greenAccent,
          icon: Icons.play_arrow,
          label: "Listen",
          onTap: _toggleListen,
        ),
      ],
    );
  }

  Widget _buildAudioButton({
    required bool isActive,
    required AnimationController controller,
    required Color color,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.4),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 32,
            ),
          ),
        ),
        const SizedBox(width: 16),
        SoundWave(isActive: isActive, controller: controller),
      ],
    );
  }
}

class SoundWave extends StatelessWidget {
  final bool isActive;
  final AnimationController controller;

  const SoundWave({
    super.key,
    required this.isActive,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(25, (i) {
            final height = isActive
                ? max(4.0, 10 + 20 * sin(controller.value * 2 * pi + i))
                : 10.0;
            return Container(
              width: 4,
              height: height,
              margin: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(2),
              ),
            );
          }),
        );
      },
    );
  }
}
