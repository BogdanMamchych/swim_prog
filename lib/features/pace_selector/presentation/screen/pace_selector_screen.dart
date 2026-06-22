import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:swim_prog/features/pace_selector/data/providers/pace_providers.dart';
import 'package:swim_prog/features/pace_selector/presentation/widgets/pace_slider_widget.dart';
import 'package:swim_prog/features/pace_selector/presentation/widgets/pace_widget.dart';
import 'package:swim_prog/features/pace_selector/presentation/widgets/text_widget.dart';

class PaceSelectorScreen extends ConsumerWidget {
  const PaceSelectorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final buttonColor = ref.watch(currentSkillProvider).color;
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                text: "What's your fastest\n100m freestyle?",
                color: theme.colorScheme.onSurface,
                size: 28,
                fontWeight: FontWeight.bold,
                lineHeight: 1.2,
              ),
              const SizedBox(height: 16),
              TextWidget(
                text: "This helps us build a more accurate plan\nfor you.",
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                size: 16,
                fontWeight: FontWeight.w400,
                lineHeight: 1.4,
              ),
              const PaceWidget(),
              const PaceSliderWidget(),
              const SizedBox(height: 16),
              Center(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  decoration: BoxDecoration(
                    color: buttonColor,
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: [
                      BoxShadow(
                        color: buttonColor.withValues(alpha: 0.4),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () => context.go("/user_list"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 100,
                        vertical: 15,
                      ),
                    ),
                    child: const TextWidget(
                      text: "Continue",
                      color: Colors.black,
                      size: 28,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}