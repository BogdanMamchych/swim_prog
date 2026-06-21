import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swim_prog/features/pace_selector/presentation/widgets/pace_slider_widget.dart';
import 'package:swim_prog/features/pace_selector/presentation/widgets/pace_widget.dart';
import 'package:swim_prog/features/pace_selector/presentation/widgets/text_widget.dart';

class PaceSelectorScreen extends ConsumerWidget {
  const PaceSelectorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A1128),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                text: "What's your fastest\n100m freestyle?",
                color: Colors.white,
                size: 28,
                fontWeight: FontWeight.bold,
                lineHeight: 1.2,
              ),
              const SizedBox(height: 16),
              TextWidget(
                text: "This helps us build a more accurate plan\nfor you.",
                color: Colors.white.withValues(alpha: 0.6),
                size: 16,
                fontWeight: FontWeight.w400,
                lineHeight: 1.4,
              ),
              const PaceWidget(),
              const PaceSliderWidget(),
            ],
          ),
        ),
      ),
    );
  }
}