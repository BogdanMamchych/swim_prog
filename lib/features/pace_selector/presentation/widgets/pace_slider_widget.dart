import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swim_prog/features/pace_selector/data/providers/pace_providers.dart';
import 'package:swim_prog/features/pace_selector/presentation/widgets/pace_track_shape.dart';

class PaceSliderWidget extends ConsumerWidget {
  const PaceSliderWidget({super.key});

  String _formatDuration(double seconds) {
    final int totalSeconds = seconds.round();
    final int minutes = totalSeconds ~/ 60;
    final int remainingSeconds = totalSeconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final duration = ref.watch(paceProvider);
    final config = ref.watch(paceConfigProvider);
    final tickMarks = ref.watch(tickMarksProvider);
    final colors = ref.watch(colorsProvider);
    final value = duration.inSeconds.toDouble();

    final double minTime = config.minTime.inSeconds.toDouble();
    final double maxTime = config.maxTime.inSeconds.toDouble();
    final double totalRange = maxTime - minTime;
    final skills = config.marks.toList();

    return LayoutBuilder(
      builder: (context, constraints) {
        final double totalWidth = constraints.maxWidth;

        const double paddingLeft = 10.0;
        const double paddingRight = 10.0;
        final double usableWidth = totalWidth - paddingLeft - paddingRight;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 25,
              width: totalWidth,
              child: Stack(
                children: List.generate(skills.length, (index) {
                  final double startSec = skills[index].startTime.inSeconds.toDouble();
                  final double endSec = skills[index].endTime.inSeconds.toDouble();
                  
                  final double centerValue = (startSec + endSec) / 2;
                  final double percentage = (centerValue - minTime) / totalRange;
                  final double leftPosition = paddingLeft + (percentage * usableWidth);

                  final isSelected = value >= startSec && value < endSec;

                  return Positioned(
                    left: leftPosition,
                    child: FractionalTranslation(
                      translation: const Offset(-0.5, 0.0),
                      child: Text(
                        skills[index].skill,
                        style: TextStyle(
                          color: isSelected ? skills[index].color : Colors.white24, // Сделали неактивные видимыми на темном фоне
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            
            const SizedBox(height: 5),

            // 2. СЛАЙДЕР
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 10,
                trackShape: PaceTrackShape(
                  minTime: minTime,
                  maxTime: maxTime,
                  colors: colors,
                  tickMarks: tickMarks,
                ),
                activeTrackColor: Colors.transparent,
                inactiveTrackColor: Colors.transparent,
                thumbColor: Colors.white,
                overlayColor: Colors.white12,
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
              ),
              child: Slider(
                value: value,
                min: minTime,
                max: maxTime,
                onChanged: (newValue) {
                  ref
                      .read(paceProvider.notifier)
                      .setDuration(Duration(seconds: newValue.round()));
                },
              ),
            ),

            const SizedBox(height: 5),

            SizedBox(
              height: 20,
              width: totalWidth,
              child: Stack(
                children: List.generate(tickMarks.length, (index) {
                  if (index == 0) {
                    return const SizedBox.shrink();
                  }

                  final double markValue = tickMarks[index].toDouble();
                  final double percentage = (markValue - minTime) / totalRange;
                  final double leftPosition = paddingLeft + (percentage * usableWidth);
                  double translationX = -0.5;
                  if (index == tickMarks.length - 1) translationX = -1.0;

                  final bool isActive = value.round() == markValue.round();

                  return Positioned(
                    left: leftPosition,
                    child: FractionalTranslation(
                      translation: Offset(translationX, 0.0),
                      child: Text(
                        _formatDuration(markValue),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                          color: isActive ? Colors.white : Colors.white60,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        );
      },
    );
  }
}
