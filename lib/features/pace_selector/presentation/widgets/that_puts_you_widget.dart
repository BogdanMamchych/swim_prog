import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swim_prog/features/pace_selector/data/providers/pace_providers.dart';
import 'package:swim_prog/features/pace_selector/presentation/widgets/text_widget.dart';

class ThatPutsYouWidget extends ConsumerWidget {
  const ThatPutsYouWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSkill = ref.watch(currentSkillProvider);
    return SafeArea(
      child: Center(
        child: Column(
          children: [
            TextWidget(
              text: "That puts you at:",
              color: Colors.white.withValues(alpha: 0.6),
              size: 16,
              fontWeight: FontWeight.w400,
              lineHeight: 1.4,
            ),
            TextWidget(
              text: currentSkill.skill,
              color: currentSkill.color,
              size: 24,
              fontWeight: FontWeight.w400,
              lineHeight: 1.4,
            ),
          ],
        ),
      ),
    );
  }
}
