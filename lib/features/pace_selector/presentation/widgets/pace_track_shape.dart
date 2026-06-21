import 'package:flutter/material.dart';

class PaceTrackShape extends SliderTrackShape {
  final double minTime;
  final double maxTime;
  final List<double> tickMarks;
  final List<Color> colors;

  const PaceTrackShape({
    required this.minTime,
    required this.maxTime,
    required this.tickMarks,
    required this.colors,
  });

  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final trackHeight = sliderTheme.trackHeight ?? 8;
    final double thumbRadius =
        sliderTheme.thumbShape?.getPreferredSize(isEnabled, isDiscrete).width ?? 10.0;

    final double trackLeft = offset.dx + thumbRadius;
    final double trackWidth = parentBox.size.width - (thumbRadius * 2);
    final double trackTop = offset.dy + (parentBox.size.height - trackHeight) / 2;

    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required Offset thumbCenter,
    required TextDirection textDirection,
    Offset? secondaryOffset,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final canvas = context.canvas;
    final trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
    );

    final List<double> milestones = [];
    if (tickMarks.isEmpty || tickMarks.first != minTime) {
      milestones.add(minTime);
    }
    milestones.addAll(tickMarks);
    if (milestones.last != maxTime) {
      milestones.add(maxTime);
    }

    final totalDuration = maxTime - minTime;
    if (totalDuration <= 0) return;

    double currentLeft = trackRect.left;
    final paintObj = Paint()..style = PaintingStyle.fill;

    final int segmentsCount = milestones.length - 1;

    for (int i = 0; i < segmentsCount; i++) {
      final startSec = milestones[i];
      final endSec = milestones[i + 1];

      if (startSec >= endSec) continue;

      final segmentDuration = endSec - startSec;
      final segmentWidth = (segmentDuration / totalDuration) * trackRect.width;

      paintObj.color = i < colors.length ? colors[i] : Colors.grey;

      final segmentRect = Rect.fromLTWH(
        currentLeft,
        trackRect.top,
        segmentWidth,
        trackRect.height,
      );

      canvas.drawRect(segmentRect, paintObj);

      currentLeft += segmentWidth;
    }
  }
}
