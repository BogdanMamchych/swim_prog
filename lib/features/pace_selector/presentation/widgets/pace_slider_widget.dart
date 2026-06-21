import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swim_prog/features/pace_selector/data/providers/pace_providers.dart';
import 'package:swim_prog/features/pace_selector/presentation/widgets/pace_track_shape.dart';

class PaceSliderWidget extends ConsumerWidget {
  const PaceSliderWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final duration = ref.watch(paceProvider);
    final config = ref.watch(paceConfigProvider);
    final paceLength = ref.watch(paceLengthProvider);
    final tickMarks = ref.watch(tickMarksProvider);
    final colors = ref.watch(colorsProvider);
    final value = duration.inSeconds.toDouble();

    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        trackHeight: 10,
        trackShape: PaceTrackShape(
          minTime: config.minTime.inSeconds.toDouble(),
          maxTime: config.maxTime.inSeconds.toDouble(),
          colors: colors,
          tickMarks: tickMarks
        ),
        activeTrackColor: Colors.transparent,
        inactiveTrackColor: Colors.transparent,
        thumbColor: Colors.white,
        overlayColor: Colors.white12,
        thumbShape: const RoundSliderThumbShape(
          enabledThumbRadius: 10,
        ),
      ),
      child: Slider(
        value: value,
        min: config.minTime.inSeconds.toDouble(),
        max: config.maxTime.inSeconds.toDouble(),
        divisions:
            paceLength,
        onChanged: (newValue) {
          ref.read(paceProvider.notifier).setDuration(
            Duration(seconds: newValue.round()),
          );
        },
      ),
    );
  }
}