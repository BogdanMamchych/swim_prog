import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swim_prog/features/pace_selector/data/providers/pace_providers.dart';

class SwimmingLevelMarksWidget extends ConsumerWidget{
  const SwimmingLevelMarksWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final duration = ref.watch(paceProvider);
    final config = ref.watch(paceConfigProvider);
    final skills = config.marks.toList();
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: skills.map((skill) {
        final isSelected = skill.startTime < duration && skill.endTime > duration;
        return Text(
          skill.skill,
          style: TextStyle(
            color: isSelected ? skill.color : Colors.black54,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        );
      }).toList(),
    );
  }

}