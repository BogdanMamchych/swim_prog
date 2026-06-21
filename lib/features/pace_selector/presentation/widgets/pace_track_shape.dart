import 'package:flutter/material.dart';

class PaceTrackShape extends SliderTrackShape {
  final double minTime;
  final double maxTime;
  final List<double> tickMarks;
  final List<Color> colors;
  const PaceTrackShape({required this.minTime, required this.maxTime, required this.tickMarks, required this.colors});

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
        sliderTheme.thumbShape?.getPreferredSize(isEnabled, isDiscrete).width ??
        10.0;

    final double trackLeft = offset.dx + thumbRadius;
    final double trackWidth = parentBox.size.width - (thumbRadius * 2);
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;

    return Rect.fromLTWH(
      trackLeft, trackTop, trackWidth, trackHeight
    );
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

    final timeMilestones = [minTime, 75.0, 105.0, 150.0, maxTime];

    final colors = [
      const Color(0xFF00C853), // Elite (from minTime to 75)
      const Color(0xFF64DD17), // Advanced (from 75 to 105)
      const Color(0xFFFFD600), // Intermediate (from 105 to 150)
      const Color(0xFFFF6D00), // Beginner (from 150 to maxTime)
    ];

    final totalDuration = maxTime - minTime;
    double currentLeft = trackRect.left;

    for (int i = 0; i < colors.length; i++) {
      final startSec = timeMilestones[i];
      final endSec = timeMilestones[i + 1];

      if (startSec >= endSec) continue;

      final segmentDuration = endSec - startSec;
      final segmentWidth = (segmentDuration / totalDuration) * trackRect.width;

      final segmentRect = Rect.fromLTWH(
        currentLeft,
        trackRect.top,
        segmentWidth - (i == colors.length - 1 ? 0 : 2),
        trackRect.height,
      );

      final isActive =
          thumbCenter.dx >= segmentRect.left &&
          thumbCenter.dx <= segmentRect.right;

      final paint = Paint()
        ..color = isActive ? colors[i] : colors[i].withValues(alpha: 0.2);

      canvas.drawRRect(
        RRect.fromRectAndRadius(segmentRect, const Radius.circular(4)),
        paint,
      );

      currentLeft += segmentWidth;
    }
  }
}
