import 'package:flutter/material.dart';

class PaceTrackShape extends SliderTrackShape {
  const PaceTrackShape();

  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final trackHeight = sliderTheme.trackHeight ?? 8;

    return Rect.fromLTWH(
      offset.dx,
      offset.dy + (parentBox.size.height - trackHeight) / 2,
      parentBox.size.width,
      trackHeight,
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

    const colors = [
      Color(0xFF00C853), // Elite
      Color(0xFF64DD17), // Advanced
      Color(0xFFFFD600), // Intermediate
      Color(0xFFFF6D00), // Beginner
    ];

    final segmentWidth = trackRect.width / colors.length;

    final currentSegment =
    ((thumbCenter.dx - trackRect.left) / segmentWidth)
        .floor()
        .clamp(0, colors.length - 1);

    for (int i = 0; i < colors.length; i++) {
      final segmentRect = Rect.fromLTWH(
        trackRect.left + i * segmentWidth,
        trackRect.top,
        segmentWidth - 2,
        trackRect.height,
      );

      final isActive = i == currentSegment;

      final paint = Paint()
        ..color = isActive
            ? colors[i]
            : colors[i].withValues(alpha: 0.2);

      canvas.drawRRect(
        RRect.fromRectAndRadius(
          segmentRect,
          const Radius.circular(4),
        ),
        paint,
      );
    }
  }
}