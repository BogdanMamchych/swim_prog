import 'package:flutter/material.dart';
import 'package:swim_prog/features/pace_selector/presentation/widgets/pace_track_shape.dart';

class PaceSliderWidget extends StatefulWidget {
  const PaceSliderWidget({super.key});

  @override
  State<PaceSliderWidget> createState() => _PaceSliderWidgetState();
}

class _PaceSliderWidgetState extends State<PaceSliderWidget> {
  double value = 50;

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        trackHeight: 10,
        trackShape: const PaceTrackShape(),

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
        min: 0,
        max: 50,
        divisions: 50,
        onChanged: (newValue) {
          setState(() {
            value = newValue;
          });
        },
      ),
    );
  }
}